<template>
  <div>
    <!-- search area -->
    <div class="searcharea">
      <el-input v-model="params.name" placeholder="Enter book's name" style="width: 200px; margin-left: 2px"></el-input>
      <el-input v-model="params.isbn" placeholder="Enter ISBN" style="width: 200px; margin-left: 2px"></el-input>
      <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search"
        @click="load">Search</el-button>
      <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right"
        @click="reset">Reset</el-button>
    </div>
    <!-- table area -->
    <div class="tablearea">
      <el-table :data="tableData" style="width: 100%" stripe>
        <el-table-column prop="cover" label="Cover" width="100">
          <template v-slot="scope1">
            <el-image :src="scope1.row.cover" style="width: 60%; height: 60%"></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="isbn" label="ISBN" width="120"></el-table-column>
        <el-table-column prop="name" label="Name" show-overflow-tooltip width="120"></el-table-column>
        <el-table-column prop="category" label="Category" width="130"></el-table-column>
        <el-table-column prop="author" label="Author" width="100"></el-table-column>
        <el-table-column prop="publisher" label="Publisher" show-overflow-tooltip width="100"></el-table-column>
        <el-table-column prop="publish_date" label="Publish Date" width="120"></el-table-column>
        <el-table-column prop="description" label="Description" show-overflow-tooltip width="300"></el-table-column>
        <el-table-column prop="cDate" label="Create Date" width="110"></el-table-column>
        <el-table-column prop="uDate" label="Update Date" width="110"></el-table-column>

        <el-table-column prop="credit" label="Score" width="85"></el-table-column>
        <el-table-column prop="number" label="Number" width="85">

        </el-table-column>
        <el-table-column label="Operation" width="350">



          <template v-slot="scope">
            <el-button type="success" @click="showDetail(scope.row.isbn)">
              Detail
            </el-button>

            <el-dialog style="text-align: center" :visible.sync="dialogVisible" append-to-body>
              <el-table :data="dialogTableData" >
                <el-table-column prop="id" label="ID" ></el-table-column>
                <el-table-column prop="position" label="Position" ></el-table-column>
                <el-table-column prop="status" label="Status" ></el-table-column>
                <el-table-column prop="handler" label="Handler" ></el-table-column>
                <el-table-column prop="isbn" label="ISBN" ></el-table-column>
              </el-table>
            </el-dialog>


            <el-button type="primary" @click="$router.push('/editBook?isbn=' + scope.row.isbn)">Edit</el-button>
            <el-popconfirm confirm-button-text='Yes' cancel-button-text='No'
              title="Are you sure you want to delete this row of data？" @confirm="del(scope.row.isbn)">
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
      dialogVisible: false, // 控制对话框的显示
      dialogTableData: [], // 对话框中表格的数据
      tableData: [],
      total: 0,
      params: {
        pageNum: 1,
        pageSize: 10,
        email: '',
        uid: '',
      },
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      request.get('book/page', {
        params: this.params
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list
          this.total = res.data.total
          // console.log(this.tableData)
        }
      })
    },

    del(isbn) {
      request.delete('book/delete/' + isbn).then(res => {
        if (res.code === '200') {
          this.$notify.success('Deleted')
          this.load()
        } else {
          this.$notify.error(res.msg)
        }
      })
    },
    showDetail(isbn) {
      this.dialogVisible = true

      console.log(isbn)
      request.get('bookUnity/getBooks/'+isbn).then(res => {
        if (res.code === '200') {
          this.dialogTableData = res.data
          // console.log(this.dialogTableData)
        }
        else {
          this.$notify.error(res.msg)
        }
      })
    },

    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 10,
        name: '',
        isbn: '',
      }
      this.value = ''
      this.load()
    },

    changePageNum(pageNum) {
      this.params.pageNum = pageNum
      this.load()
    }
  }
}
</script>

<style scoped lang="scss">
.el-tooltip__popper {
  max-width: 400px;
  /* modify the width of the popper */
}

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
  .el-table-column{
    text-align: center;
  }
}
</style>