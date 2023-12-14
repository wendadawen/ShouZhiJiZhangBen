import router from '@ohos.router';
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean';

import { AccountDataBean } from '../database/databean/AccountDataBean';


import PageViewModel from '../viewmodel/PageViewModel';
import { AccountSignalComponent } from './AccountSigalComponent';
import Prompt from '@system.prompt';
import promptAction from '@ohos.promptAction';
import { ACCOUNT_TABLE, QUERY_ACCOUNT_All } from '../common/constants/AccountConstants';
import { FULL, THEME_BACKGROUND } from '../common/constants/GlobalConstants';
import { GROUP_BACKGROUND, GROUP_BORDER_RADIUS, GROUP_DIVIDER_END, GROUP_DIVIDER_START, GROUP_END_WIDTH, GROUP_HEAD_BACKGROUND, GROUP_HEAD_FONT_SIZE, GROUP_MARGIN_BOTTOM, GROUP_PADDING } from '../common/constants/DetailAreaConstants';

@Component
export struct DetailAreaComponent {
  @Link category: string
  @Link year: number
  @Link month: number
  @Link day: number
  @Link data: Array<AccountGroupItemBean>
  @Builder itemHead(text:string, zhichu: number, shouru: number) {
    Row(){
      Text(text)
        .fontSize(GROUP_HEAD_FONT_SIZE)
        .padding(10)
      Text("支出:-"+zhichu.toFixed(2)+"    收入:+"+shouru.toFixed(2))
        .fontSize(GROUP_HEAD_FONT_SIZE)
        .padding(10)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(GROUP_HEAD_BACKGROUND)
    .borderRadius(GROUP_BORDER_RADIUS)
    .width(FULL)
  }
  @Builder itemEnd(index1: number, index2: number) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($rawfile("accountdelete.png"))
        .width(GROUP_END_WIDTH)
        .objectFit(ImageFit.Cover)
    }
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      promptAction.showDialog({
        title: '确认删除',
        message: '',
        buttons: [{ text: '取消', color: '#000000', }, { text: '确认', color: '#000000', }],
      }).then(val => {
        if(val.index===1){
          ACCOUNT_TABLE.deleteData(this.data[index1].items[index2], (val)=>{
            QUERY_ACCOUNT_All((ret)=>{this.data=ret;})
          })
        }
      })
    })
  }
  build() {
    Column() {
      List() {
        ForEach(this.data, (item: AccountGroupItemBean, index1) => {
          ListItemGroup({header:this.itemHead(item.year+"年"+item.month+"月"+item.day+"日", item.zhichu, item.shouru)}){
            ForEach(item.items, (item: AccountDataBean, index2)=>{
              ListItem() {
                AccountSignalComponent({ item: item })
              }
              .swipeAction({ end: this.itemEnd.bind(this, index1, index2) })
            }, (index, item)=>index+JSON.stringify(item))
          }
          .divider({ strokeWidth: 2, color: THEME_BACKGROUND, startMargin: GROUP_DIVIDER_START, endMargin: GROUP_DIVIDER_END })
          .backgroundColor(GROUP_BACKGROUND)
          .margin({bottom: GROUP_MARGIN_BOTTOM})
          .borderRadius(GROUP_BORDER_RADIUS)
          .padding({left:GROUP_PADDING, right: GROUP_PADDING})
        }, (item, index) => index + JSON.stringify(item))
      }
      .width(FULL)
    }
    .width(FULL)
  }
}
