
import relationalStore from '@ohos.data.relationalStore';
import { AccountDataBean } from '../databean/AccountDataBean';
import Rdb from '../rdb';

const tableName:string =  'accountTable'
const sqlCreate:string = 'CREATE TABLE IF NOT EXISTS accountTable(id INTEGER PRIMARY KEY AUTOINCREMENT,' +
' category TEXT, detail TEXT, amount INTEGER, isIncome INTEGER, year INTEGER, month INTEGER, day INTEGER)'
const columns:Array<string> = ['id', 'category', 'detail', 'amount', 'isIncome', 'year', 'month', 'day']
export default class AccountTable {
  private accountTable = new Rdb(tableName, sqlCreate,columns);

  constructor(callback: Function=()=>{}) {
    this.accountTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function=()=>{}) {
    this.accountTable.getRdbStore(callback);
  }

  insertData(account: AccountDataBean, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    this.accountTable.insertData(valueBucket, callback);
  }

  deleteData(account: AccountDataBean, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName);
    predicates.equalTo('id', account.id);
    this.accountTable.deleteData(predicates, callback);
  }

  updateData(account: AccountDataBean, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    let predicates = new relationalStore.RdbPredicates(tableName);
    predicates.equalTo('id', account.id);
    this.accountTable.updateData(predicates, valueBucket, callback);
  }

  query(predicates: relationalStore.RdbPredicates, callback: Function) {
    this.accountTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {callback([]);}
      else {
        resultSet.goToFirstRow();
        const result: AccountDataBean[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: AccountDataBean = new AccountDataBean();
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.category = resultSet.getString(resultSet.getColumnIndex('category'))
          tmp.detail = resultSet.getString(resultSet.getColumnIndex('detail'))
          tmp.amount = resultSet.getDouble(resultSet.getColumnIndex('amount'))
          tmp.isIncome = resultSet.getDouble(resultSet.getColumnIndex('isIncome'))
          tmp.year = resultSet.getDouble(resultSet.getColumnIndex('year'))
          tmp.month = resultSet.getDouble(resultSet.getColumnIndex('month'))
          tmp.day = resultSet.getDouble(resultSet.getColumnIndex('day'))
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
  // 查询所有
  queryAll(callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName);
    this.query(predicates, callback)
  }

  // 按类别查询
  queryByCategory(category: string, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates.equalTo("category", category)
    this.query(predicates, callback)
  }

  // 按时间查询
  queryByTime(year: number, month: number, day: number, callback: Function){
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates
      .beginWrap()
      .lessThan("year", year)
      .endWrap()
      .or()
      .beginWrap()
      .equalTo("year", year)
      .and()
      .lessThan("month", month)
      .endWrap()
      .or()
      .beginWrap()
      .equalTo("year", year)
      .equalTo("month", month)
      .and()
      .lessThanOrEqualTo("day", day)
      .endWrap()
    this.query(predicates, callback)
  }

  // 按内容查询
  queryByDetail(detail: string, callback: Function){
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates.contains("detail", detail)
      .or()
      .contains("category", detail)
    this.query(predicates, callback)
  }

  // 按金额查询
  queryByAmount(amountMin: number, amountMax: number, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates.lessThanOrEqualTo("amount", amountMax)
      .greaterThanOrEqualTo("amount", amountMin)
    this.query(predicates, callback)
  }

  // 按年月查询:
  queryByYearAndMonth(year: number, month: number, isPay: boolean, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates.equalTo("year", year)
      .equalTo("month", month)
      .equalTo("isIncome", isPay==false?1:0)
    this.query(predicates, callback)
  }
  // 按年查询:
  queryByYear(year: number, isPay: boolean, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(tableName)
    predicates.equalTo("year", year)
      .equalTo("isIncome", isPay==false?1:0)
    this.query(predicates, callback)
  }
}

function generateBucket(account: AccountDataBean): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.id = account.id;
  obj.category = account.category;
  obj.detail = account.detail;
  obj.amount = account.amount;
  obj.isIncome = account.isIncome;
  obj.year = account.year;
  obj.month = account.month;
  obj.day = account.day;
  return obj;
}
