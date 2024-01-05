<template>
    <el-table :data="booksData" style="width: 100%">
        <el-table-column prop="id" label="ID"></el-table-column>
        <el-table-column prop="position" label="Position"></el-table-column>
        <el-table-column prop="handler" label="Handler"></el-table-column>
        <el-table-column prop="isbn" label="ISBN"></el-table-column>
        <el-table-column prop="status" label="Status"></el-table-column>
    </el-table>
</template>
  
  

<script>
import request from "@/utils/request";
import moment from "moment/moment";

export default {
    name: "List",

    data() {
        return {
            booksData: [],
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
        this.loadBooks();
    },

    methods: {
        loadBooks() {
            request.get('/bookUnity/getBooks/1234567890').then(res => {
                if (res.code === '200') {
                    this.booksData = res.data;
                    console.log(this.booksData);
                } else {
                    console.error('Failed to fetch books:', res.msg);
                }
            })
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
  
<style scoped></style>