
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean'
import { EARN_LIST, PAY_LIST, QUERY_ACCOUNT_All, QUERY_ACCOUNT_BY_CATEGORY } from '../common/constants/AccountConstants'
import { FULL } from '../common/constants/GlobalConstants'
import { TAB_CONTENT_SELECT_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_ALL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_DIALOG_DELETEIMAGE_WIDTH, TAB_CONTENT_SELECT_CATEGORY_DIALOG_EARNNAME, TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEAD_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEIGHT, TAB_CONTENT_SELECT_CATEGORY_DIALOG_LANES, TAB_CONTENT_SELECT_CATEGORY_DIALOG_MARGIN, TAB_CONTENT_SELECT_CATEGORY_DIALOG_PADDING, TAB_CONTENT_SELECT_CATEGORY_DIALOG_PAYNAME, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING, TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_WIDTH, TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE, TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE_HEIGHT, TAB_CONTENT_SELECT_CATEGORY_IMAGE_WIDTH, TAB_CONTENT_SELECT_CATEGORY_TEXT_FONT_SIZE, TAB_CONTENT_SELECT_CATEGORY_TEXT_WIDTH } from '../common/constants/TabConstants'

@CustomDialog
struct DialogComponent {
  @Link category:string
  controller: CustomDialogController

  @Link data: Array<AccountGroupItemBean>

  @Builder itemHead(text:string) {
    Text(text)
      .width(FULL)
      .fontColor(TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEAD_BACKGROUND)
  }
  build() {
    Column() {
      Stack(){
        Text(TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE)
          .width(FULL)
          .height(FULL)
          .textAlign(TextAlign.Center)
        Image($r("app.media.exit"))
          .width(TAB_CONTENT_SELECT_CATEGORY_DIALOG_DELETEIMAGE_WIDTH)
          .height(FULL)
          .objectFit(ImageFit.Contain)
          .position({x:0,y:0})
          .onClick(()=>{this.controller.close()})
      }
      .width(FULL)
      .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_TITLE_HEIGHT)
      Column(){
        Text(TAB_CONTENT_SELECT_CATEGORY_ALL)
          .textAlign(TextAlign.Center)
          .onClick(()=>{
            this.category = TAB_CONTENT_SELECT_CATEGORY_ALL
            QUERY_ACCOUNT_All((ret)=>{this.data=ret})
            this.controller.close()
          })
          .width(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_WIDTH)
          .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT)
          .fontColor(TAB_CONTENT_SELECT_CATEGORY_ALL===this.category?
            TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED:
            TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL)
          .backgroundColor(TAB_CONTENT_SELECT_CATEGORY_ALL===this.category?
            TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED:
            TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL)
      }
      .width(FULL).alignItems(HorizontalAlign.Start)
      .padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING)
      .margin({bottom: TAB_CONTENT_SELECT_CATEGORY_DIALOG_MARGIN})
      Column(){
        List(){
          ListItemGroup({header:this.itemHead(TAB_CONTENT_SELECT_CATEGORY_DIALOG_PAYNAME)}){
            ForEach(PAY_LIST, (item: string)=>{
              ListItem(){
                Text(item)
                  .textAlign(TextAlign.Center)
                  .onClick(()=>{
                    this.category = item
                    QUERY_ACCOUNT_BY_CATEGORY(this.category, (ret)=>{this.data=ret})
                    this.controller.close()
                  }).width(FULL)
                  .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT)
                  .fontColor(item===this.category?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED:
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL)
                  .backgroundColor(item===this.category?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED:
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL)
              }.padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING)
            }, (index, item)=>index+JSON.stringify(item))
          }
          .margin({bottom: TAB_CONTENT_SELECT_CATEGORY_DIALOG_MARGIN})
          ListItemGroup({header:this.itemHead(TAB_CONTENT_SELECT_CATEGORY_DIALOG_EARNNAME)}){
            ForEach(EARN_LIST, (item: string)=>{
              ListItem(){
                Text(item).textAlign(TextAlign.Center)
                  .onClick(()=>{
                    this.category = item
                    QUERY_ACCOUNT_BY_CATEGORY(this.category, (ret)=>{this.data=ret})
                    this.controller.close()
                  })
                  .width(FULL).height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_HEIGHT)
                  .fontColor(item===this.category?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_ACTIVATED:
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_FONT_COLOR_NORMAL)
                  .backgroundColor(item===this.category?
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_ACTIVATED:
                    TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_BACKGROUND_COLOR_NORMAL)
              }.padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_SIGNAL_PADDING)
            }, (index, item)=>index+JSON.stringify(item))
          }
        }
        .lanes(TAB_CONTENT_SELECT_CATEGORY_DIALOG_LANES)
        .width(FULL).height(FULL)
      }.width(FULL)
    }
    .height(TAB_CONTENT_SELECT_CATEGORY_DIALOG_HEIGHT).width(FULL)
    .padding(TAB_CONTENT_SELECT_CATEGORY_DIALOG_PADDING)
    .backgroundColor(TAB_CONTENT_SELECT_CATEGORY_DIALOG_BACKGROUND)
  }
}

@Component
export struct DetailSelectCategoryComponent {
  @Link category: string
  @Link year: number
  @Link month: number
  @Link day: number
  @Link data: Array<AccountGroupItemBean>
  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogComponent({category:$category, data: $data}),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
  })
  aboutToDisappear() {
    delete this.dialogController, // 删除dialogController
    this.dialogController = undefined // 将dialogController置空
  }
  build(){
    Row(){
      Text(this.category)
        .width(TAB_CONTENT_SELECT_CATEGORY_TEXT_WIDTH).height(FULL)
        .fontSize(TAB_CONTENT_SELECT_CATEGORY_TEXT_FONT_SIZE)
        .textAlign(TextAlign.Center)
      Divider().vertical(true).height("60%").color('#182431').opacity(0.6)
      Image($rawfile("select_category.png"))
        .objectFit(ImageFit.Contain)
        .width(TAB_CONTENT_SELECT_CATEGORY_IMAGE_WIDTH)
        .height(FULL)
    }
    .backgroundColor(TAB_CONTENT_SELECT_BACKGROUND)
    .onClick(()=>{
      if (this.dialogController != undefined) {
        let now: Date = new Date()
        this.year = now.getFullYear()
        this.month = now.getMonth()+1
        this.day = now.getDate()
        this.dialogController.open()
      }
    })
  }
}

