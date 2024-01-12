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
        <el-table-column prop="uid" label="User ID" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="username" label="Username" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="phone" label="Phone" width="120"></el-table-column>
        <el-table-column prop="name" label="Book Name" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="isbn" label="ISBN" width="120"></el-table-column>
        <el-table-column prop="bstatus" label="Status" width="100">
          <template v-slot="scope0">
            <el-tag type="warning" v-if="scope0.row.bstatus === 'Borrowed'">
              {{ scope0.row.bstatus }}
            </el-tag>
            <el-tag type="success" v-else-if="scope0.row.bstatus === 'Returned'">
              {{ scope0.row.bstatus }}
            </el-tag>
          </template>

        </el-table-column>
        <el-table-column prop="cdate" label="Borrow Date" width="110" :formatter="createDateFormat"></el-table-column>
        <el-table-column prop="duration" label="Days" width="55"></el-table-column>
        <el-table-column prop="rdate" label="Due Date" width="110" :formatter="dueDateFormat"></el-table-column>
        <el-table-column prop="notification" label="Notification" width="120s">
          <template v-slot="scope1">
            <el-tag type="success" v-if="scope1.row.bstatus === 'Returned'">
              Returned
            </el-tag>
            <el-tag type="danger" v-else-if="scope1.row.notification === 'past due'">
              {{ scope1.row.notification }}
            </el-tag>
            <el-tag type="primary" v-else-if="scope1.row.notification === 'almost due'">
              {{ scope1.row.notification }}
            </el-tag>
            <el-tag type="warning" v-else-if="scope1.row.notification === 'at the due date'">
              {{ scope1.row.notification }}
            </el-tag>
            <el-tag type="success" v-else-if="scope1.row.notification === 'before due'">
              {{ scope1.row.notification }}
            </el-tag>
          </template>

        </el-table-column>
        <el-table-column label="Credit" width="80">
          <template v-slot="scope4">
            <span :style="{ color: calculateFee(scope4.row).color }">
              {{ calculateFee(scope4.row).fee }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="Management" width="110">
          <template v-slot="scope2">
            <el-button type="primary" style="margin-left: 2px;" @click="bookReturn(scope2.row)"
              v-if="scope2.row.bstatus === 'Borrowed'">
              Return
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="Operation" width="110">
          <template v-slot="scope">
            <el-popconfirm confirm-button-text='Yes' cancel-button-text='No'
              title="Are you sure you want to delete this row of data？" @confirm="del(scope.row)">
              <el-button style="margin-left: 2px;" slot="reference" type="danger">Delete</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
        <el-table-column label="SendEmail" width="110">
          <template v-slot="scope3">
            <el-popconfirm confirm-button-text='Yes' cancel-button-text='No' title="Send Email？"
              @confirm="sendEmail(scope3.row)">
              <el-button style="margin-left: 2px;" slot="reference" type="danger">Send</el-button>
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
import moment from "moment";

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
    // console.log(moment("2023-01-05 23:12:22").format("YYYY-MM-DD"))
  },

  methods: {
    load() {
      request.get('borrow/page', {
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
      const today = moment();
      const dueDate = moment(row.rdate);
      const credit = row.credit; // 假设书籍的积分值在每行数据的credit字段中
      if (row.bstatus === 'Returned') {
        return { fee: ``, color: 'green' };
      }
      if (today.isSame(dueDate, 'day')) {
        // 当天归还
        return { fee: `0`, color: 'green' };
      } else if (today.isBefore(dueDate)) {
        // 提前归还
        const daysBefore = dueDate.diff(today, 'days');
        const refund = credit * daysBefore;
        return { fee: `+${refund}`, color: 'green' };
      } else {
        // 逾期归还
        const daysOverdue = today.diff(dueDate, 'days');
        const fine = credit * daysOverdue * 2;
        return { fee: `-${fine}`, color: 'red' };
      }
    },
    del(row) {
      console.log(this.tableData);
      const email = row.email
      const isbn = row.isbn
      const id = row.id

      request.delete('borrow/delete/' + email + '&' + isbn + '&' + id).then(res => {
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

    bookReturn(row) {
      // console.log(row)
      request.post('/return/save', row).then(res => {
        if (res.code === '200') {
          this.$notify.success('Book returned')
          location.reload()
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    sendEmail(row) {
      const postdata = {
        email: row.email,
        isbn: row.isbn
      }
      console.log(postdata)
      request.post('/email/sendWarning', postdata).then(res => {
        if (res.code === '200') {
          this.$notify.success('Email sent')
        } else {
          this.$notify.error(res.msg)
        }
      })
    },

    createDateFormat(row) {
      return moment(row.cdate).format("YYYY-MM-DD") // a useful tool to format datetime
    },
    dueDateFormat(row) {
      return moment(row.rdate).format("YYYY-MM-DD")
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