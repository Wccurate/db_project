<template>
    <div>
        <!-- search area -->
        <div class="searcharea">
            <el-input v-model="params.email" placeholder="Enter email" style="width: 200px; margin-left: 2px"></el-input>
            <el-input v-model="params.isbn" placeholder="Enter book's isbn"
                style="width: 200px; margin-left: 2px"></el-input>
            <el-button type="primary" style="margin-left: 2px; height: 40px" icon="el-icon-search"
                @click="load">Search</el-button>
            <el-button type="warning" style="margin-left: 2px; height: 40px" icon="el-icon-refresh-right"
                @click="reset">Reset</el-button>
        </div>
        <!-- table area -->
        <div class="tablearea">
            <el-table :data="tableData" style="width: 100%" stripe>
                <el-table-column prop="id" label="ID" show-overflow-tooltip width="100"></el-table-column>
                <el-table-column prop="isbn" label="ISBN" width="140"></el-table-column>
                <el-table-column prop="email" label="email" width="200"></el-table-column>
                <el-table-column prop="reserveTime" label="ReserveTime" width="130"
                    :formatter="dueDateFormat"></el-table-column>
                <el-table-column prop="duration" label="duration" width="120"></el-table-column>
                <el-table-column prop="bookUnityID" label="status" width="80">
                    <template v-slot="scope1">
                        <el-tag :type="scope1.row.bookUnityID == '-1' ? 'warning' : 'success'">
                            {{ scope1.row.bookUnityID == '-1' ? 'Unavailable' : 'Available' }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column  label="Get Book" width="100">
                    <template v-slot="scope2">
                        <el-button type="primary" style="margin-left: 0px;" @click="getBook(scope2.row)"
                            v-if="scope2.row.bookUnityID != '-1'">
                            Get
                        </el-button>
                    </template>
                </el-table-column>
                <!-- <el-table-column fixed="right" label="Operation">
                    <template v-slot="scope">
                        <el-popconfirm confirm-button-text='Yes' cancel-button-text='No'
                            title="Are you sure you want to delete this row of data？" @confirm="del(scope.row)">
                            <el-button style="margin-left: 2px;" slot="reference" type="danger">Delete</el-button>
                        </el-popconfirm>
                    </template>
                </el-table-column> -->
                <el-table-column  label="SendEmail" width="110">
                    <template v-slot="scope3">
                        <el-popconfirm confirm-button-text='Yes' cancel-button-text='No'
                            title="Send Email?" @confirm="sendEmail(scope3.row)">
                            <el-button style="margin-left: 2px;" slot="reference" type="danger"
                                       v-if="scope3.row.bookUnityID != '-1'">
                              Send
                            </el-button>
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
    name: "reserveList",

    data() {
        return {
            tableData: [],
            total: 0,
            params: {
                pageNum: 1,
                pageSize: 10,
                email: '',
                isbn: ''
            },
        }
    },

    created() {
        this.load()
        // console.log(moment("2023-01-05 23:12:22").format("YYYY-MM-DD"))
    },

    methods: {
        load() {
            request.get('/reserve/page', {
                params: this.params
            }).then(res => {
                if (res.code === '200') {
                    this.tableData = res.data.list
                    this.total = res.data.total
                }
            })
            console.log(this.tableData)
        },

        del(row) {
            // console.log(this.tableData);
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

        getBook(row) {
            // console.log(row)
            request.post('/reserve/getBook', row).then(res => {
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
  .el-table-column{
    text-align: center;
  }
}

</style>