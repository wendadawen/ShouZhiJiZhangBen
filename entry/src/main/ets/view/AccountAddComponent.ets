import { DetailSelectTimeComponent } from './DetailSelectTimeComponent'
import prompt from '@ohos.prompt'
import { AccountDataBean } from '../database/databean/AccountDataBean'
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean'
import AccountTable from '../database/tables/AccountTable'
import { ACCOUNT_TABLE, EARN_LIST, PAY_LIST, QUERY_ACCOUNT_All, QUERY_ACCOUNT_BY_CATEGORY } from '../common/constants/AccountConstants'
import { ADD_DIALOG_AMOUNT_PLACEHOLDER, ADD_DIALOG_CONFIRM_FONT_SIZE, ADD_DIALOG_CONFIRM_HEIGHT, ADD_DIALOG_CONFIRM_TEXT, ADD_DIALOG_DETAIL_PLACEHOLDER, ADD_DIALOG_DIVIDER_COLOR, ADD_DIALOG_HINT1, ADD_DIALOG_HINT2, ADD_DIALOG_MARGIN, ADD_HEIGHT, ADD_POSITION_X, ADD_POSITION_Y, ADD_WIDTH } from '../common/constants/AddConstants'
import { FULL, THEME_BACKGROUND } from '../common/constants/GlobalConstants'
import { TAB_CONTENT_SELECT_CATEGORY_ALL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_DIALOG_DELETEIMAGE_WIDTH, TAB_CONTENT_SELECT_CATEGORY_DIALOG_EARNNAME, TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEAD_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEIGHT, TAB_CONTENT_SELECT_CATEGORY_DIALOG_LANES, TAB_CONTENT_SELECT_CATEGORY_DIALOG_MARGIN, TAB_CONTENT_SELECT_CATEGORY_DIALOG_PADDING, TAB_CONTENT_SELECT_CATEGORY_DIALOG_PAYNAME, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_WIDTH, TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE, TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE_HEIGHT } from '../common/constants/TabConstants'

@CustomDialog
struct DialogComponent {
  controller: CustomDialogController
  @State inputAmount: string = ""
  @Link data: Array<AccountGroupItemBean>
  @Link account: AccountDataBean
  @Link category: string
  @State year: number = 2023
  @State month: number = 1
  @State day: number = 1

  @Builder itemHead(text: string) {
    Text(text)
      .width(FULL)
      .fontColor(TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEAD_BACKGROUND)
  }

  build() {
    Column() {
      Image($r("app.media.exit"))
        .width(TAB_CONTENT_SELECT_CATEGORY_DIALOG_DELETEIMAGE_WIDTH)
        .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE_HEIGHT)
        .objectFit(ImageFit.Contain)
        .position({ x: 0, y: 0 })
        .onClick(() => {
          this.controller.close()
        })
      DetailSelectTimeComponent({ category: $category,year: $year, month: $month, day: $day, data: $data })
      Divider().strokeWidth(2).color(ADD_DIALOG_DIVIDER_COLOR)
      // 金额输入框
      TextInput({ placeholder: ADD_DIALOG_AMOUNT_PLACEHOLDER })
        .backgroundColor(Color.White)
        .type(InputType.Normal)
        .margin({ top: ADD_DIALOG_MARGIN, bottom: ADD_DIALOG_MARGIN })
        .onChange((value: string) => {this.inputAmount = value;})

      // 详细内容输入框
      TextInput({ placeholder: ADD_DIALOG_DETAIL_PLACEHOLDER })
        .margin({ bottom: ADD_DIALOG_MARGIN })
        .onChange((value: string) => {this.account.detail = value})

      // 选择分类
      Column() {
        List() {
          ListItemGroup({ header: this.itemHead(TAB_CONTENT_SELECT_CATEGORY_DIALOG_PAYNAME) }) {
            ForEach(PAY_LIST, (item: string) => {
              ListItem() {
                Text(item)
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    this.account.isIncome = 0
                    this.account.category = item
                  })
                  .width(FULL)
                  .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT)
                  .fontColor(item === this.account.category ?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED :
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL)
                  .backgroundColor(item === this.account.category ?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED :
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL)
              }.padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING)
            }, (index, item) => index + JSON.stringify(item))
          }
          .margin({ bottom: TAB_CONTENT_SELECT_CATEGORY_DIALOG_MARGIN })

          ListItemGroup({ header: this.itemHead(TAB_CONTENT_SELECT_CATEGORY_DIALOG_EARNNAME) }) {
            ForEach(EARN_LIST, (item: string) => {
              ListItem() {
                Text(item)
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    this.account.isIncome = 1
                    this.account.category = item
                  })
                  .width(FULL)
                  .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT)
                  .fontColor(item === this.account.category ?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED :
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL)
                  .backgroundColor(item === this.account.category ?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED :
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL)
              }.padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING)
            }, (index, item) => index + JSON.stringify(item))
          }
        }
        .lanes(TAB_CONTENT_SELECT_CATEGORY_DIALOG_LANES)
        .width(FULL)
      }
      .margin({bottom: ADD_DIALOG_MARGIN})

      // 确认按钮
      Button() {
        Text(ADD_DIALOG_CONFIRM_TEXT)
          .fontSize(ADD_DIALOG_CONFIRM_FONT_SIZE)
          .fontColor(Color.White)
      }
      .width(FULL)
      .height(ADD_DIALOG_CONFIRM_HEIGHT)
      .margin({ bottom: ADD_DIALOG_MARGIN})
      .onClick(() => {
        if (this.account.category === '') {
          prompt.showToast({ message: ADD_DIALOG_HINT1, bottom: "70vp" });
        } else {
          let regex: RegExp = new RegExp('[1-9][0-9]*[.]*[0-9]*');
          let matchValue: Array<string> | null = this.inputAmount.match(regex);
          if (matchValue !== null && matchValue[0] === this.inputAmount) {
            this.account.amount = Number(this.inputAmount);
            this.account.year = this.year
            this.account.month = this.month
            this.account.day = this.day
            let accountDataBean: AccountDataBean = JSON.parse(JSON.stringify(this.account)) as AccountDataBean
            ACCOUNT_TABLE.insertData(accountDataBean, (id: number) => {
              accountDataBean.id = id;
              QUERY_ACCOUNT_All((ret) => {
                this.data = ret;
              })
            })
            this.controller?.close();
          } else {
            prompt.showToast({ message: ADD_DIALOG_HINT2, bottom: "70vp" });
          }
        }
      })
    }
    .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEIGHT)
    .width(FULL)
    .padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_PADDING)
    .backgroundColor(TAB_CONTENT_SELECT_CATEGORY_DIALOG_BACKGROUND)
  }
}
@Component
export struct AccountAddComponent{
  @State newAccount: AccountDataBean = new AccountDataBean()
  @Link data: Array<AccountGroupItemBean>
  @Link category: string

  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogComponent({category: $category,account: $newAccount, data: $data}),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });
  aboutToDisappear() {
    delete this.dialogController, // 删除dialogController
    this.dialogController = undefined // 将dialogController置空
  }
  build(){
    Row(){
      Image($rawfile("add.png"))
    }
    .width(ADD_WIDTH)
    .height(ADD_HEIGHT)
    .position({ x: ADD_POSITION_X, y: ADD_POSITION_Y })
    .onClick(()=>{
      if (this.dialogController != undefined) {
        this.newAccount.category = ""
        this.newAccount.detail = ""
        this.newAccount.amount = 0
        this.newAccount.id = undefined
        this.dialogController.open()
      }
    })
  }
}