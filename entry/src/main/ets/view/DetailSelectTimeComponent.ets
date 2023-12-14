
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean'
import { QUERY_ACCOUNT_BY_TIME } from '../common/constants/AccountConstants'
import { FULL } from '../common/constants/GlobalConstants'
import { TAB_CONTENT_SELECT_BACKGROUND, TAB_CONTENT_SELECT_CATEGORY_ALL, TAB_CONTENT_SELECT_HEIGHT, TAB_CONTENT_SELECT_TIME_IMAGE_WIDTH } from '../common/constants/TabConstants'

@Component
export struct DetailSelectTimeComponent {
  @Link year: number
  @Link month: number
  @Link day: number
  @Link category: string
  @Link data: Array<AccountGroupItemBean>
  selectedDate: Date = new Date() // 自动获取系统时间

  setTime(){
    this.year = this.selectedDate.getFullYear()
    this.month = this.selectedDate.getMonth()+1
    this.day = this.selectedDate.getDate()
    this.category = TAB_CONTENT_SELECT_CATEGORY_ALL
    QUERY_ACCOUNT_BY_TIME(this.year, this.month, this.day, (ret)=>{this.data=ret;})
  }
  aboutToAppear(){
    this.setTime()
  }
  build(){
    Row(){
      Text(this.year+"年"+this.month+"月"+this.day+"日")
      Image($rawfile("zhankai.png"))
        .objectFit(ImageFit.Contain)
        .height(FULL).width(TAB_CONTENT_SELECT_TIME_IMAGE_WIDTH)
    }
    .height(TAB_CONTENT_SELECT_HEIGHT)
    .onClick(() => {
      DatePickerDialog.show({
        start: new Date("2000-1-1"),
        end: new Date(),
        selected: this.selectedDate,
        onAccept: (value: DatePickerResult) => {
          this.selectedDate.setFullYear(value.year, value.month, value.day)
          this.setTime()
        }
      })
    })
    .backgroundColor(TAB_CONTENT_SELECT_BACKGROUND)
  }
}

