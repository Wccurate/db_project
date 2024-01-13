<template>
  <div>
    <!-- search area -->
    <div class="searcharea">
      <el-input v-model="params.username" placeholder="Enter username" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.name" placeholder="Enter book's name" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.isbn" placeholder="Enter book's isbn" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search"
        @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right"
        @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <div class="tablearea">
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="uid" label="User ID" show-overflow-tooltip width="150"></el-table-column>
        <el-table-column prop="username" label="Username" show-overflow-tooltip width="120"></el-table-column>
        <el-table-column prop="phone" label="Phone" width="100"></el-table-column>
        <el-table-column prop="name" label="Book Name" show-overflow-tooltip width="200"></el-table-column>
        <el-table-column prop="isbn" label="ISBN" width="100"></el-table-column>
        <el-table-column prop="bstatus" label="Status" width="100"></el-table-column>
        <el-table-column prop="cdate" label="Borrow Date" width="120" :formatter="createDateFormat"></el-table-column>
        <el-table-column prop="duration" label="Days" width="100"></el-table-column>
        <el-table-column prop="rdate" label="Due Date" width="100" :formatter="dueDateFormat"></el-table-column>
        <el-table-column prop="adate" label="Return Date" width="110" :formatter="returnDateFormat"></el-table-column>
        <el-table-column label="Fee" width="100" >
          <template v-slot="scope">
            <span :style="{ color: calculateFee(scope.row).color }">
              {{ calculateFee(scope.row).fee }}
            </span>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="Operation" width="110" >
          <template v-slot="scope">
            <el-popconfirm confirm-button-text='Yes' cancel-button-text='No'
              title="Are you sure you want to delete this row of data？" @confirm="del(scope.row)">
              <el-button style="margin-left: 2px;" slot="reference" type="danger">Delete</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
      <!-- page -->
      <el-pagination style="margin-top: 5px;" background :current-page="params.pageNum" :page-size="params.pageSize"
        @current-change="changePageNum" layout="prev, pager, next" :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";
import moment from "moment/moment";

export default {
  name: "List",

  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        pageNum: 1,
        pageSize: 10,
        username: '',
        isbn: '',
        name: ''
      },
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      request.get('return/page', {
        params: this.params
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
          console.log(this.tableData);
        }
      })
    },
    calculateFee(row) {
      const today = moment(row.adate);
      const dueDate = moment(row.rdate);
      const credit = row.credit; // 假设书籍的积分值在每行数据的credit字段中

      if (today.isSame(dueDate, 'day')) {
        // 当天归还
        return { fee: `0`, color: 'green' };
      } else if (today.isBefore(dueDate)) {
        // 提前归还
        const daysBefore = dueDate.diff(today, 'days')+1;
        const refund = credit * daysBefore;
        console.log(daysBefore);
        return { fee: `+${refund}`, color: 'green' };
      } else {
        // 逾期归还
        const daysOverdue = today.diff(dueDate, 'days');
        const fine = credit * daysOverdue * 2;
        return { fee: `-${fine}`, color: 'red' };
      }
    },
    del(row) {
      const email = row.email
      const isbn = row.isbn

      request.delete('retern/delete/' + email + '&' + isbn).then(res => {
        if (res.code === '200') {
          this.$notify.success('Deleted')
          this.load()
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        email: '',
        isbn: '',
      }
      this.value = ''
      this.load()
    },

    changePageNum(pageNum) {
      this.params.pageNum = pageNum
      this.load()
    },

    createDateFormat(row) {
      return moment(row.cdate).format("YYYY-MM-DD") // a useful tool to format datetime
    },
    dueDateFormat(row) {
      return moment(row.rdate).format("YYYY-MM-DD")
    },
    returnDateFormat(row) {
      return moment(row.adate).format("YYYY-MM-DD")
    },
  }
}
</script>

<style scoped lang="scss">
.searcharea {
  background-color: #ffffff;
  border-radius: 10px;
  padding: 10px;
  box-shadow: 0 0 10px #ccc;
  margin-bottom: 10px;
  margin-top: 17px;
  width: auto;
}

.tablearea {
  background-color: #ffffff;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0 0 10px #ccc;
  text-align: center;

  .el-table-column {
    text-align: center;
  }
}
</style>