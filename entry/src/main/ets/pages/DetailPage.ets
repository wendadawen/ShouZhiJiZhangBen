
import { DetailAreaComponent } from '../view/DetailAreaComponent';
import { DetailSelectCategoryComponent } from '../view/DetailSelectCategoryComponent';
import { DetailSelectTimeComponent } from '../view/DetailSelectTimeComponent';
import { TabItemBean } from '../common/bean/TabItemBean';
import { AccountAddComponent } from '../view/AccountAddComponent';
import { AccountGroupItemBean } from '../common/bean/AccountGroupItemBean';
import { SearchItemComponent } from '../view/SearchItemComponent';
import { StatisticsComponent } from '../view/StatisticsComponent';
import { ACCOUNT_TABLE, DATAS, QUERY_ACCOUNT_All } from '../common/constants/AccountConstants';
import { TAB_BAR_BACKGROUND, TAB_BAR_DETAIL, TAB_BAR_STATISTICS, TAB_CONTENT_SEARCH_MARGIN_BOTTOM, TAB_CONTENT_SELECT_CATEGORY_ALL, TAB_CONTENT_SELECT_CATEGORY_WIDTH, TAB_CONTENT_SELECT_HEIGHT, TAB_CONTENT_TITLE, TAB_CONTENT_TITLE_FONT_COLOR, TAB_CONTENT_TITLE_FONT_SIZE, TAB_CONTENT_TITLE_HEIGHT, TAB_HEIGHT, TAB_IMAGE_HEIGHT, TAB_IMAGE_WIDTH, TAB_TEXT_FONT_COLOR_ACTIVATED, TAB_TEXT_FONT_COLOR_NORMAL, TAB_TEXT_FONT_SIZE, TAB_TEXT_MARGIN_TOP, TAB_WIDTH } from '../common/constants/TabConstants';
import { FULL, MARGIN_LEFT, MARGIN_RIGHT, MARGIN_TOP, THEME_BACKGROUND } from '../common/constants/GlobalConstants';

@Entry
@Component
struct ListPage {
  @State currentTabIndex: number = 0;
  @State category: string = TAB_CONTENT_SELECT_CATEGORY_ALL
  @State year: number = 2023
  @State month: number = 1
  @State day: number = 1
  @State data: Array<AccountGroupItemBean> = []

  aboutToAppear(){
    ACCOUNT_TABLE.getRdbStore(()=>{
      for (let i = 0; i < 300; i++) {
        ACCOUNT_TABLE.insertData(DATAS[i], ()=>{
          if(i==299) QUERY_ACCOUNT_All((ret)=>{this.data=ret})
        })
      }
      //QUERY_ACCOUNT_All((ret)=>{this.data=ret})
    })
  }

  @Builder BuildTabs(item: TabItemBean, index: number) {
    Column() {
      Image(this.currentTabIndex === index ? item.imageActivated : item.imageNormal)
        .width(TAB_IMAGE_WIDTH)
        .height(TAB_IMAGE_HEIGHT)
      Text(item.title)
        .margin({ top: TAB_TEXT_MARGIN_TOP })
        .fontSize(TAB_TEXT_FONT_SIZE)
        .fontColor(this.currentTabIndex === index ? TAB_TEXT_FONT_COLOR_ACTIVATED : TAB_TEXT_FONT_COLOR_NORMAL)
    }
    .justifyContent(FlexAlign.Center)
  }
  @Builder Title() {
    Row() {Text(TAB_CONTENT_TITLE).fontColor(TAB_CONTENT_TITLE_FONT_COLOR).fontSize(TAB_CONTENT_TITLE_FONT_SIZE)}
    .width(FULL).height(TAB_CONTENT_TITLE_HEIGHT).justifyContent(FlexAlign.Center).margin({ top: MARGIN_TOP})
  }

  build() {
    Column() {
      Tabs({ index: this.currentTabIndex, barPosition: BarPosition.End }) {
        // 主页面
        TabContent() {
          Stack(){
            Column() {
              this.Title()  // 标题
              SearchItemComponent({category: $category, year:$year, month: $month, day: $day,
                data: $data, currentTabIndex: $currentTabIndex})
              Row(){
                // 选择分类
                DetailSelectCategoryComponent({category: $category, year:$year, month: $month,
                  day: $day, data: $data})
                  .width(TAB_CONTENT_SELECT_CATEGORY_WIDTH).height(FULL)// 选择类型
                // 选择时间
                DetailSelectTimeComponent({category: $category, year: $year, month: $month,
                  day: $day, data: $data})// 选择年月
              }
              .width(FULL).height(TAB_CONTENT_SELECT_HEIGHT)
              .justifyContent(FlexAlign.SpaceBetween)
              .margin({bottom: TAB_CONTENT_SEARCH_MARGIN_BOTTOM})
              DetailAreaComponent({category: $category, year:$year, month: $month, day: $day,
                data: $data})  // 内容
            }
            .width(FULL)
            .height(FULL)
            .padding({left: MARGIN_LEFT, right: MARGIN_RIGHT})
            // 添加
            AccountAddComponent({category: $category, data: $data})
          }
        }
        .tabBar(this.BuildTabs(TAB_BAR_DETAIL, 0))
        .backgroundColor(THEME_BACKGROUND)
        // 统计页面
        TabContent() {StatisticsComponent()}
        .tabBar(this.BuildTabs(TAB_BAR_STATISTICS, 1))
        .backgroundColor(THEME_BACKGROUND)
      }
      .barWidth(TAB_WIDTH).barHeight(TAB_HEIGHT)
      .backgroundColor(TAB_BAR_BACKGROUND).onChange(index => {this.currentTabIndex = index;})
    }
    .backgroundColor(THEME_BACKGROUND)
  }
}

