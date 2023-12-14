
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean'
import { QUERY_ACCOUNT_All, QUERY_ACCOUNT_BY_DETAIL } from '../common/constants/AccountConstants'
import { FULL } from '../common/constants/GlobalConstants'
import { TAB_CONTENT_SEARCH_BORDER_RADIUS, TAB_CONTENT_SEARCH_BUTTON_TEXT, TAB_CONTENT_SEARCH_HEIGHT, TAB_CONTENT_SEARCH_MARGIN_BOTTOM, TAB_CONTENT_SEARCH_PLACEHOLDER, TAB_CONTENT_SEARCH_PLACEHOLDER_COLOR, TAB_CONTENT_SEARCH_PLACEHOLDER_FONT_SIZE, TAB_CONTENT_SEARCH_PLACEHOLDER_FONT_WEIGHT, TAB_CONTENT_SEARCH_TEXT_FONT_SIZE, TAB_CONTENT_SELECT_CATEGORY_ALL } from '../common/constants/TabConstants'

@Component
export struct SearchItemComponent {
  @Link data: Array<AccountGroupItemBean>
  @Link currentTabIndex: number
  @Link category: string
  @Link year: number
  @Link month: number
  @Link day: number
  build(){
    Search({
      placeholder: TAB_CONTENT_SEARCH_PLACEHOLDER
    })
      .width(FULL)
      .height(TAB_CONTENT_SEARCH_HEIGHT)
      .border({ radius: TAB_CONTENT_SEARCH_BORDER_RADIUS})
      .placeholderColor(TAB_CONTENT_SEARCH_PLACEHOLDER_COLOR)
      .placeholderFont({ size: TAB_CONTENT_SEARCH_PLACEHOLDER_FONT_SIZE,
        weight: TAB_CONTENT_SEARCH_PLACEHOLDER_FONT_WEIGHT, family: 'serif', style: FontStyle.Normal })
      .textFont({ size: TAB_CONTENT_SEARCH_TEXT_FONT_SIZE })
      .margin({ bottom: TAB_CONTENT_SEARCH_MARGIN_BOTTOM })
      .searchButton(TAB_CONTENT_SEARCH_BUTTON_TEXT)
      .onChange((val:string)=>{
        if(val=="" || val==null || val==undefined) {
          QUERY_ACCOUNT_All((ret)=>{this.data=ret;})
          return;
        }
        let now: Date = new Date()
        this.year = now.getFullYear()
        this.month = now.getMonth()+1
        this.day = now.getDate()
        this.category = TAB_CONTENT_SELECT_CATEGORY_ALL
        QUERY_ACCOUNT_BY_DETAIL(val, (ret)=>{this.data=ret;})
      })
  }
}