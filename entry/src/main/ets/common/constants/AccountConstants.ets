import HashMap from '@ohos.util.HashMap'
import { AccountDataBean } from '../../database/databean/AccountDataBean';
import AccountTable from '../../database/tables/AccountTable';
import { AccountGroupItemBean } from '../bean/AccountGroupItemBean';
import call from '@ohos.telephony.call';
import HashSet from '@ohos.util.HashSet';

/****************************************************************************************
   收入支出信息集合
 ****************************************************************************************/

interface AccountItem {
  icon: Resource;
  category: string;
}
// 支出集合
export const PAY_LIST: Array<string> = ["餐饮","交通","服饰","购物","工作","教育","娱乐","运动","缴费","旅行","宠物","医疗","保险","公益"]
// 收入集合
export const EARN_LIST: Array<string> = ["生意","工资","奖金","人情","红包","理财"]
// 支出信息集合
export const PAY_INFO_LIST: Array<AccountItem> = [
  { icon: $rawfile('餐饮.png'), category: '餐饮' },
  { icon: $rawfile('交通.png'), category: '交通' },
  { icon: $rawfile('服饰.png'), category: '服饰' },
  { icon: $rawfile('购物.png'), category: '购物' },
  { icon: $rawfile('工作.png'), category: '工作' },
  { icon: $rawfile('教育.png'), category: '教育' },
  { icon: $rawfile('娱乐.png'), category: '娱乐' },
  { icon: $rawfile('运动.png'), category: '运动' },
  { icon: $rawfile('缴费.png'), category: '缴费' },
  { icon: $rawfile('旅行.png'), category: '旅行' },
  { icon: $rawfile('宠物.png'), category: '宠物' },
  { icon: $rawfile('医疗.png'), category: '医疗' },
  { icon: $rawfile('保险.png'), category: '保险' },
  { icon: $rawfile('公益.png'), category: '公益' },
]
// 收入信息集合
export const EARN_INFO_LIST: Array<AccountItem> = [
  { icon: $rawfile('生意.png'), category: '生意' },
  { icon: $rawfile('工资.png'), category: '工资' },
  { icon: $rawfile('奖金.png'), category: '奖金' },
  { icon: $rawfile('人情.png'), category: '人情' },
  { icon: $rawfile('红包.png'), category: '红包' },
  { icon: $rawfile('理财.png'), category: '理财' },
]
// 获取icon
export function GET_ACCOUNT_ICON(category: string){
  for (let i = 0; i < PAY_INFO_LIST.length; i++) {
    const element = PAY_INFO_LIST[i];
    if(element.category == category) return element.icon
  }
  for (let i = 0; i < EARN_INFO_LIST.length; i++) {
    const element = EARN_INFO_LIST[i];
    if(element.category == category) return element.icon
  }
  return $rawfile("other.png")
}

/****************************************************************************************
      查询账目信息接口
 ****************************************************************************************/

// 账目表类型
export const ACCOUNT_TABLE: AccountTable = new AccountTable(() => {});
// 查询所有账目信息
export function QUERY_ACCOUNT_All(callback: Function){
  let data:Array<AccountGroupItemBean> = []
  ACCOUNT_TABLE.queryAll((ret: AccountDataBean[])=>{
    ret.sort((a: AccountDataBean,b:AccountDataBean)=>{
      if(a.year === b.year) {
        if(a.month === b.month) return b.day - a.day
        else return b.month - a.month
      }
      return b.year - a.year
    })
    let mp: HashSet<string> = new HashSet()
    for(let i = 0; i < ret.length; ++ i) {
      const a = ret[i]
      const key = ""+a.year+a.month+a.day
      if(mp.has(key)== false) {
        mp.add(key)
        data.push(new AccountGroupItemBean(a.year,a.month,a.day))
      }
      data[data.length-1].insert(a)
    }
    callback(data)
  })
}
// 通过种类查询账目信息
export function QUERY_ACCOUNT_BY_CATEGORY(category: string, callback: Function){
  let data:Array<AccountGroupItemBean> = []
  ACCOUNT_TABLE.queryByCategory(category, (ret: AccountDataBean[])=>{
    ret.sort((a: AccountDataBean,b:AccountDataBean)=>{
      if(a.year === b.year) {
        if(a.month === b.month) return b.day - a.day
        else return b.month - a.month
      }
      return b.year - a.year
    })
    let mp: HashSet<string> = new HashSet()
    for(let i = 0; i < ret.length; ++ i) {
      const a = ret[i]
      const key = ""+a.year+a.month+a.day
      if(mp.has(key)== false) {
        mp.add(key)
        data.push(new AccountGroupItemBean(a.year,a.month,a.day))
      }
      data[data.length-1].insert(a)
    }
    callback(data)
  })
}
// 通过时间查询账目信息
export function QUERY_ACCOUNT_BY_TIME(year: number, month: number, day: number, callback: Function){
  let data:Array<AccountGroupItemBean> = []
  ACCOUNT_TABLE.queryByTime(year, month, day, (ret: AccountDataBean[])=>{
    ret.sort((a: AccountDataBean,b:AccountDataBean)=>{
      if(a.year === b.year) {
        if(a.month === b.month) return b.day - a.day
        else return b.month - a.month
      }
      return b.year - a.year
    })
    let mp: HashSet<string> = new HashSet()
    for(let i = 0; i < ret.length; ++ i) {
      const a = ret[i]
      const key = ""+a.year+a.month+a.day
      if(mp.has(key)== false) {
        mp.add(key)
        data.push(new AccountGroupItemBean(a.year,a.month,a.day))
      }
      data[data.length-1].insert(a)
    }
    callback(data)
  })
}
// 通过内容查询账目信息
export function QUERY_ACCOUNT_BY_DETAIL(detail: string, callback: Function){
  let data:Array<AccountGroupItemBean> = []
  ACCOUNT_TABLE.queryByDetail(detail, (ret: AccountDataBean[])=>{
    ret.sort((a: AccountDataBean,b:AccountDataBean)=>{
      if(a.year === b.year) {
        if(a.month === b.month) return b.day - a.day
        else return b.month - a.month
      }
      return b.year - a.year
    })
    let mp: HashSet<string> = new HashSet()
    for(let i = 0; i < ret.length; ++ i) {
      const a = ret[i]
      const key = ""+a.year+a.month+a.day
      if(mp.has(key)== false) {
        mp.add(key)
        data.push(new AccountGroupItemBean(a.year,a.month,a.day))
      }
      data[data.length-1].insert(a)
    }
    callback(data)
  })
}
// 通过金额查询账目信息
export function QUERY_ACCOUNT_BY_AMOUNT(amountMin: number, amountMax: number, callback: Function) {
  let data:Array<AccountGroupItemBean> = []
  ACCOUNT_TABLE.queryByAmount(amountMin, amountMax, (ret: AccountDataBean[])=>{
    ret.sort((a: AccountDataBean,b:AccountDataBean)=>{
      if(a.year === b.year) {
        if(a.month === b.month) return b.day - a.day
        else return b.month - a.month
      }
      return b.year - a.year
    })
    let mp: HashSet<string> = new HashSet()
    for(let i = 0; i < ret.length; ++ i) {
      const a = ret[i]
      const key = ""+a.year+a.month+a.day
      if(mp.has(key)== false) {
        mp.add(key)
        data.push(new AccountGroupItemBean(a.year,a.month,a.day))
      }
      data[data.length-1].insert(a)
    }
    callback(data)
  })
}

/****************************************************************************************
 一些初始化的数据
 ****************************************************************************************/

// 生成随机整数
function getRandomInt(min: number, max: number): number {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}
// 生成随机数
function generateRandomDecimalInRange(min:number, max:number) {
  const randomValue = (Math.random() * (max - min) + min).toFixed(2);
  return parseFloat(randomValue);
}

// 生成随机日期
function getRandomDate(start: Date, end: Date): Date {
  return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

// 随机生成detail内容的函数
function generateRandomDetail(): string {
  const details = [
    "购物血拼",
    "出去旅游",
    "医院看病",
    "买菜做饭",
    "购买电子产品",
    "房租水电费",
    "加班加点拿奖金",
    "投资理财",
    "朋友聚餐",
    "运动健身消费",
    "这是我的电话：13728946579",
    "这是我的电话：16809865467",
    "这是我的电话：65478906541",
    "这是我的电话：14536789786"
  ];
  const randomIndex = getRandomInt(0, details.length - 1);
  return details[randomIndex];
}

export const DATAS: AccountDataBean[] = function(){
  const initialData: AccountDataBean[] = [];
  for (let i = 0; i < 1000; i++) {
    const isIncome = Math.random() < 0.5 ? 1 : 0; // 随机选择收入或支出
    const categoryList = isIncome ? EARN_LIST : PAY_LIST;
    const category = categoryList[getRandomInt(0, categoryList.length - 1)];
    const detail = generateRandomDetail();
    const amount = generateRandomDecimalInRange(1, 1000);
    const year = getRandomInt(2021, 2023);
    const month = getRandomInt(5, 11);
    const day = getRandomInt(5, 16);
    const data = new AccountDataBean(undefined, category, detail, amount, isIncome, year, month, day);
    initialData.push(data);
  }
  return initialData
}()
