export class AccountDataBean {
  id: number;
  // 类别
  category: string;
  // 详细事件
  detail: string;
  // 金额
  amount: number;
  // 收入还是支出
  isIncome: number;
  // 年
  year: number;
  // 月
  month: number;
  // 日
  day: number;
  constructor(
    id: number = undefined,
    category: string = '',
    detail: string = '',
    amount: number = 0,
    isIncome: number = 0,
    year: number = 2023,
    month: number = 1,
    day: number = 1
  ) {
    this.id = id;
    this.category = category;
    this.detail = detail;
    this.amount = amount;
    this.isIncome = isIncome;
    this.year = year;
    this.month = month;
    this.day = day;
  }
}