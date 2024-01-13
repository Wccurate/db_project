<template>
    <div style="padding: 10px;">
        <div class="wrapper">
            <div class="fontarea">
                Add New Reserve Record</div>
            <div class="formarea" style="width: 80%; margin: auto;">
                <el-form :model="form" :rules="rules" ref="ruleForm">
                    <el-row :gutter="20">
                        <el-col :span="12">
                            <el-form-item label="ISBN: " prop="isbn">
                                <el-select v-model="form.isbn" clearable filterable placeholder="Please select ISBN"
                                    @change="selectBook" style="width: 100%;">
                                    <el-option v-for="item in books" :key="item.isbn" :label="item.isbn" :value="item.isbn">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="Book Name: " prop="name">
                                <el-input v-model="form.name" placeholder="Enter book's name" disabled></el-input>
                            </el-form-item>
                            <el-form-item label="Need Credit: " prop="credit">
                                <el-input v-model="form.credit" placeholder="Enter credit" disabled></el-input>
                            </el-form-item>
                            <el-form-item label="Number: " prop="number">
                                <el-input v-model="form.number" placeholder="Enter a number" disabled></el-input>
                            </el-form-item>
                            <el-form-item label="Reserve Days: " prop="duration">
                                <el-input-number v-model="form.duration" @change="handleChange" :min="1"
                                    :max="10"></el-input-number>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="User ID: " prop="uid">
                                <el-select v-model="form.email" clearable filterable placeholder="Please select an user ID"
                                    @change="selectUser" style="width: 100%;">
                                    <el-option v-for="item in users" :key="item.email" :label="item.uid"
                                        :value="item.email">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="Phone: " prop="phone">
                                <el-input v-model="form.phone" placeholder="Enter phone number" disabled></el-input>
                            </el-form-item>
                            <el-form-item label="Username: " prop="username">
                                <el-input v-model="form.username" placeholder="Enter username" disabled></el-input>
                            </el-form-item>
                            <el-form-item label="Score Left: " prop="acredit">
                                <el-input v-model="form.acredit" placeholder="Enter score value" disabled></el-input>
                            </el-form-item>

                        </el-col>
                    </el-row>
                    <!-- button area -->
                    <div style="text-align: center; margin-top: 20px;">
                        <el-button type="primary" @click="save">Submit</el-button>
                    </div>
                </el-form>
            </div>
        </div>
    </div>
</template>

  
<script>
import request from "@/utils/request";
import { duration } from "moment";

export default {
    name: "addReserve",

    data() {
        const checkISBN = (rule, value, callback) => {
            if (!value) {
                callback(new Error('Please enter the book\'s ISBN'))
            }
            if (!/^[0-9]{10}$/.test(value)) {
                callback(new Error('Illegal ISBN'));
            }
            callback()
        }

        const checkEmail = (rule, value, callback) => {
            if (!value) {
                callback(new Error('Please enter the email address'))
            }
            if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(value)) {
                callback(new Error('Illegal email address'))
            }
            callback()
        };

        const checkPhone = (rule, value, callback) => {
            if (!value) {
                callback(new Error('Please enter the phone number'))
            }
            if (!/^[1,2,3,4,5,6,7,8,9][0-9]{10}$/.test(value)) {
                callback(new Error('Illegal phone number'));
            }
            callback()
        }

        return {
            form: {
                duration: 1,
            },
            books: [],
            users: [],
            unitCredit: 0,
            // rules to check the input values
            rules: {
                username: [{ required: true, message: 'Please enter the username', trigger: 'blur' }],
                name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
                credit: [{ required: true, message: "Please enter the book's credit", trigger: 'blur' }],
                // more restrictions
                email: [{ required: true, validator: checkEmail, trigger: 'blur' }],
                phone: [{ required: true, validator: checkPhone, trigger: 'blur' }],
                isbn: [{ required: true, validator: checkISBN, trigger: 'blur' }],
            }
        }
    },

    created() {
        // get book list
        request.get('/book/list').then(res => {
            this.books = res.data
        })
        // get user list
        request.get('/user/list').then(res => {
            this.users = res.data.filter(v => v.status)
        })
    },

    methods: {
        save() {
            this.$refs['ruleForm'].validate((valid) => {
                if (valid) {
                    const now = new Date();
                    // 格式化时间为 'YYYY-MM-DD HH:mm:ss' 的格式
                    const reserveTime = `${now.getFullYear()}-${(now.getMonth() + 1).toString().padStart(2, '0')}-${now.getDate().toString().padStart(2, '0')} ${now.getHours().toString().padStart(2, '0')}:${now.getMinutes().toString().padStart(2, '0')}:${now.getSeconds().toString().padStart(2, '0')}`;

                    // 构建reserve对象，包含当前时间
                    const reserve = {
                        isbn: this.form.isbn,
                        email: this.form.email,
                        duration: this.form.duration,
                        reserveTime: reserveTime // 添加当前时间
                    }
                    request.post('/reserve/save', this.form).then(res => {
                        if (res.code === '200') {
                            this.$notify.success('Submitted')
                            this.$refs['ruleForm'].resetFields()
                            location.reload()
                        } else {
                            this.$notify.error(res.msg)
                        }
                    })
                    console.log(reserve)
                }
            })
        },
        // get data from book
        selectBook() {
            console.log(this.books)
            const book = this.books.find(v => v.isbn === this.form.isbn)
            request.get("/book/" + book.isbn).then(res => {
                this.form.name = res.data.name
                this.form.credit = res.data.credit
                this.form.number = res.data.number
                this.unitCredit = res.data.credit
                this.$forceUpdate()
            })
        },
        // get data from user
        selectUser() {
            const user = this.users.find(v => v.email === this.form.email)
            request.get("/user/" + user.email).then(res => {
                this.form.phone = res.data.phone
                this.form.username = res.data.username
                this.form.acredit = res.data.acredit
                this.$forceUpdate()
            })
        },

        handleChange() {
            this.form.credit = this.form.duration * this.unitCredit
        }
    }
}
</script>
  
<style scoped>

.wrapper {
  padding: 15px;
  display: flex;
  flex-direction: column;
  align-items: center;
  transform: translateX(-10%);
}

.formarea {
  display: flex;
  justify-content: center;
  width: 90%;
  padding-top: 0px;
}

.fontarea {
  font-size: 30px;
  font-weight: bold;
  margin-bottom: 20px;
  text-align: center;
}

.el-form {
  width: 70%;
  background-color: #ffffff;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 20px;
}


</style>