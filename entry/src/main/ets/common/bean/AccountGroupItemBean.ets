
import { AccountDataBean } from '../../database/databean/AccountDataBean'
export class AccountGroupItemBean {
  year:number
  month:number
  day:number
  items: Array<AccountDataBean>
  // 收入
  shouru: number
  // 支出
  zhichu: number

  constructor(year:number,month:number,day:number) {
    this.year = year
    this.day = day
    this.month = month
    this.items = []
    this.shouru = 0
    this.zhichu = 0
  }

  insert(accountDataBean: AccountDataBean): boolean{
    if(accountDataBean.year != this.year) return false;
    if(accountDataBean.month != this.month) return false;
    if(accountDataBean.day != this.day) return false;
    this.items.push(accountDataBean);
    if(accountDataBean.isIncome) {
      this.shouru += accountDataBean.amount
    } else {
      this.zhichu += accountDataBean.amount
    }
    return true;
  }

}