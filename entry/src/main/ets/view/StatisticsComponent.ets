
import { STATISTICS_BACKGROUND_EARN, STATISTICS_BACKGROUND_PAY, STATISTICS_FONT_COLOR_NORMAL, STATISTICS_FONT_COLOR_SELECTED, STATISTICS_INFO_HEIGHT, STATISTICS_RANK_HEIGHT, STATISTICS_SELECT_TIME_HEIGHT, STATISTICS_SELECT_TIME_IMAGE_WIDTH } from '../common/constants/StatisticsConstants'
import { AccountDataBean } from '../database/databean/AccountDataBean'
import { ACCOUNT_TABLE, GET_ACCOUNT_ICON } from '../common/constants/AccountConstants'
import { FULL } from '../common/constants/GlobalConstants'
import { AccountCategoryGroupBean } from '../common/bean/AccountCategoryGroupBean'
import HashMap from '@ohos.util.HashMap'
import HashSet from '@ohos.util.HashSet'


@Component
export struct StatisticsComponent {
  @State year: number = 2023
  @State month: number = 11
  @State isPay: boolean = true
  @State isMonth: boolean = true
  @State data: Array<AccountDataBean> = []
  @State dataCategory: Array<AccountCategoryGroupBean> = []
  @State amountAll: number = 0
  selectedDate: Date = new Date()

  @State linesDatas: number[] = [20, 73, 4, 51];


  @Builder signalAccountCategoryGroup(item: AccountCategoryGroupBean, index: number) {
    Row(){
      Text(index+1+"").height(FULL).width("24vp").margin({right: "12vp"}).textAlign(TextAlign.Center)
      Image(GET_ACCOUNT_ICON(item.category)).objectFit(ImageFit.Contain).height(FULL).width("24vp").margin({right: "12vp"})
      Text(item.category).height(FULL).margin({right: "170vp"})
      Image($rawfile("money_black.png")).objectFit(ImageFit.Contain).height(FULL).margin({right: "12vp"}).width("24vp")
      Text(item.amountAll.toFixed(2)+"").height(FULL)
    }.height("40vp").margin({bottom: "12vp"}).padding({left:"12vp", right:"12vp"})
  }
  setTime(){
    this.year = this.selectedDate.getFullYear()
    this.month = this.selectedDate.getMonth()+1
  }
  getInfo(){
    if(this.isMonth) {
      ACCOUNT_TABLE.queryByYearAndMonth(this.year, this.month, this.isPay, (ret: Array<AccountDataBean>)=>{
        let amountAll = 0;
        let arr: Array<AccountCategoryGroupBean> = []
        let mp: HashMap<string, number> = new HashMap()
        for(let i = 0; i < ret.length; ++ i) {
          amountAll += ret[i].amount
          if(mp.hasKey(ret[i].category)) {
            arr[mp.get(ret[i].category)].amountAll += ret[i].amount
          } else {
            mp.set(ret[i].category, arr.length)
            arr.push(new AccountCategoryGroupBean(0, ret[i].category))
            arr[mp.get(ret[i].category)].amountAll += ret[i].amount
          }
        }
        arr.sort((a, b)=>{
          return b.amountAll - a.amountAll
        })
        this.dataCategory = arr;
        this.data=ret;
        this.amountAll = amountAll;
      })
    } else {
      ACCOUNT_TABLE.queryByYear(this.year, this.isPay, (ret)=>{
        let amountAll = 0;
        let arr: Array<AccountCategoryGroupBean> = []
        let mp: HashMap<string, number> = new HashMap()
        for(let i = 0; i < ret.length; ++ i) {
          amountAll += ret[i].amount
          if(mp.hasKey(ret[i].category)) {
            arr[mp.get(ret[i].category)].amountAll += ret[i].amount
          } else {
            mp.set(ret[i].category, arr.length)
            arr.push(new AccountCategoryGroupBean(0, ret[i].category))
            arr[mp.get(ret[i].category)].amountAll += ret[i].amount
          }
        }
        arr.sort((a, b)=>{
          return b.amountAll - a.amountAll
        })
        this.dataCategory = arr;
        this.data=ret;
        this.amountAll = amountAll;
      })
    }
  }
  aboutToAppear(){
    this.setTime()
    this.getInfo()
  }
  build(){
    Column(){
      // info
      Column(){
        Row(){
          Column(){
            Text("月账单")
              .fontColor(this.isMonth? STATISTICS_FONT_COLOR_SELECTED:STATISTICS_FONT_COLOR_NORMAL)
              .fontSize("25fp")
              .onClick(()=>{
                this.isMonth = true
                this.getInfo()
              })
            Divider()
              .color(this.isMonth?STATISTICS_FONT_COLOR_SELECTED:
                this.isPay?STATISTICS_BACKGROUND_PAY: STATISTICS_BACKGROUND_EARN)
              .strokeWidth(2)
              .width("45vp")
          }
          Column(){
            Text("年账单")
              .fontColor(this.isMonth==false? STATISTICS_FONT_COLOR_SELECTED:STATISTICS_FONT_COLOR_NORMAL)
              .fontSize("25fp")
              .onClick(()=>{
                this.isMonth = false
                this.getInfo()
              })
            Divider()
              .color(this.isMonth==false?STATISTICS_FONT_COLOR_SELECTED:
                this.isPay?STATISTICS_BACKGROUND_PAY: STATISTICS_BACKGROUND_EARN)
              .strokeWidth(2)
              .width("45vp")
          }
        }
        .width("40%")
        .margin({top: "30vp", bottom: "30vp"})
        .justifyContent(FlexAlign.SpaceBetween)
        Row(){
          // 选择时间
          Row(){
            Text(this.year+"年"+(this.isMonth?this.month+"月":""))
              .fontColor(STATISTICS_FONT_COLOR_SELECTED)
              .fontSize("20fp")
            Image($rawfile("zhankai_white.png"))
              .objectFit(ImageFit.Contain)
              .height(FULL).width(STATISTICS_SELECT_TIME_IMAGE_WIDTH)
          }
          .height(FULL)
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1"),
              end: new Date(),
              selected: this.selectedDate,
              onAccept: (value: DatePickerResult) => {
                this.selectedDate.setFullYear(value.year, value.month, value.day)
                this.setTime()
                this.getInfo()
              }
            })
          })
          Row(){
            Text("支出")
              .fontColor(this.isPay?STATISTICS_FONT_COLOR_SELECTED: STATISTICS_FONT_COLOR_NORMAL)
              .fontSize("20fp")
              .height(FULL)
              .onClick(()=>{
                this.isPay = true
                this.getInfo()
              })
              .margin({right: "24vp"})
              .border({radius: "5vp", width: 1, color:
                this.isPay?STATISTICS_FONT_COLOR_SELECTED: STATISTICS_BACKGROUND_EARN})
            Text("收入")
              .fontColor(this.isPay==false?STATISTICS_FONT_COLOR_SELECTED: STATISTICS_FONT_COLOR_NORMAL)
              .fontSize("20fp")
              .height(FULL)
              .onClick(()=>{
                this.isPay = false
                this.getInfo()
              })
              .border({radius: "5vp", width: 1, color:
                this.isPay==false?STATISTICS_FONT_COLOR_SELECTED: STATISTICS_BACKGROUND_PAY})
          }
          .height(FULL)
        }
        .width(FULL)
        .height(STATISTICS_SELECT_TIME_HEIGHT)
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({bottom: "30vp"})
        .padding({left: "15vp", right: "15vp"})

        Text("共"+(this.isPay?"支出":"收入")+this.data.length+"笔，合计")
          .fontColor(STATISTICS_FONT_COLOR_NORMAL)
          .width(FULL)
          .margin({left: "30vp", bottom: "30vp"})

        Row(){
          Image($rawfile("money.png"))
            .objectFit(ImageFit.Contain)
            .height(FULL)
            .margin({right: "30vp"})
          Text(this.amountAll.toFixed(2)+"")
            .fontColor(STATISTICS_FONT_COLOR_SELECTED)
            .fontSize("40fp")
        }.height("50vp")
      }
      .width(FULL)
      .height(STATISTICS_INFO_HEIGHT)
      .backgroundColor(this.isPay?STATISTICS_BACKGROUND_PAY: STATISTICS_BACKGROUND_EARN)

      // rank
      Column(){
        Text((this.isPay?"支出":"收入")+"排行榜")
          .margin("12vp")
        List(){
          ForEach(this.dataCategory, (item: AccountCategoryGroupBean, index: number)=>{
            ListItem(){
              this.signalAccountCategoryGroup(item, index)
            }
          }, (item, index)=>index+JSON.stringify(item))
        }
        .width(FULL)
      }
      .width(FULL)
      .height(STATISTICS_RANK_HEIGHT)
      .backgroundColor(Color.White)
    }
  }
}
