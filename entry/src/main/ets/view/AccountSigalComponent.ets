
import { GET_ACCOUNT_ICON } from '../common/constants/AccountConstants'

import { SIGNAL_AMOUNT_FONT_COLOR_EARN, SIGNAL_AMOUNT_FONT_COLOR_PAY, SIGNAL_AMOUNT_FONT_SIZE, SIGNAL_AMOUNT_MARGIN_RIGHT, SIGNAL_CATEGORY_TEXT_FONT_COLOR, SIGNAL_CATEGORY_TEXT_FONT_SIZE, SIGNAL_DETAIL_TEXT_FONT_COLOR, SIGNAL_DETAIL_TEXT_FONT_SIZE, SIGNAL_DETAIL_TEXT_MARGIN_TOP, SIGNAL_IMAGE_MARGIN, SIGNAL_IMAGE_WIDTH } from '../common/constants/DetailAreaConstants'
import { AccountDataBean } from '../database/databean/AccountDataBean'

@Component
export struct AccountSignalComponent {
  @State item: AccountDataBean = undefined
  build(){
    Row() {
      Image(GET_ACCOUNT_ICON(this.item.category))
        .objectFit(ImageFit.Contain)
        .width(SIGNAL_IMAGE_WIDTH)
        .margin({ right: SIGNAL_IMAGE_MARGIN, left:SIGNAL_IMAGE_MARGIN })
      Column() {
        Text(this.item.category)  // 分类
          .fontSize(SIGNAL_CATEGORY_TEXT_FONT_SIZE)
          .fontColor(SIGNAL_CATEGORY_TEXT_FONT_COLOR)
          .textOverflow({ overflow: TextOverflow.Ellipsis })  // 文本超长时显示不下的文本用省略号代替
        Text(this.item.detail)  // 详细
          .fontSize(SIGNAL_DETAIL_TEXT_FONT_SIZE)
          .fontColor(SIGNAL_DETAIL_TEXT_FONT_COLOR)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: SIGNAL_DETAIL_TEXT_MARGIN_TOP })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(this.item.isIncome?"+"+this.item.amount.toFixed(2):"-"+this.item.amount.toFixed(2))  // 金额
        .fontSize(SIGNAL_AMOUNT_FONT_SIZE)
        .margin({ right: SIGNAL_AMOUNT_MARGIN_RIGHT })
        .fontColor(this.item.isIncome?SIGNAL_AMOUNT_FONT_COLOR_EARN:SIGNAL_AMOUNT_FONT_COLOR_PAY)
    }
    .height($r('app.float.list_item_height'))
  }
}