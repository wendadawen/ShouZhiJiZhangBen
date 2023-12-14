

/**
 * Binds data to components and provides interfaces.
 */
export class PageViewModel {
  /**
   * Get data sources required by the LazyForEach interface.
   *
   * @return {ListDataSource} new ListDataSource(listItems)
   */
  // getListDataSource(): ListDataSource {
  //   let listItems: Array<AccountItemData> = [];
  //   for (let i = 0; i < CommonConstants.LIST_SIZE; i++) {
  //     let itemInfo: AccountItemData = new AccountItemData();
  //     itemInfo.image = $r('app.media.ic_normal');
  //     itemInfo.category = "交通";
  //     itemInfo.detail = "坐公交车";
  //     itemInfo.amount = 2;
  //     listItems.push(itemInfo);
  //   }
  //   return new ListDataSource(listItems);
  // }

  /**
   * Get item information for the tab.
   *
   * @return {Array<TabItemInfo>} tabItems
   */
  // getTabData(): Array<TabItemBean> {
  //   let tabItems: Array<TabItemData> = [];
  //   for (let i = 0; i < CommonConstants.TAB_SIZE; i++) {
  //     let itemInfo: TabItemData = new TabItemData();
  //     itemInfo.imageOriginal = $r('app.media.ic_normal');
  //     itemInfo.imageActivated = $r('app.media.ic_activated');
  //     itemInfo.title = $r('app.string.tab_title');
  //     tabItems.push(itemInfo);
  //   }
  //   return tabItems;
  // }

  /**
   * Get detail list Data.
   *
   * @return {Array<AccountItemData>} listItems
   */
  // getDetailListData(): Array<AccountItemData> {
  //   let listItems: Array<AccountItemData> = [];
  //   for (let i = 0; i < CommonConstants.DETAIL_PAGE_LIST_SIZE; i++) {
  //     let itemInfo: AccountItemData = new AccountItemData();
  //     itemInfo.category = "标题";
  //     itemInfo.amount = 200;
  //     listItems.push(itemInfo);
  //   }
  //   return listItems;
  // }
}

let pageViewModel = new PageViewModel();

export default pageViewModel as PageViewModel;