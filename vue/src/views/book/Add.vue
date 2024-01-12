<template>
  <div>
    <div class="wrapper">
      <div class="fontarea">
        Add New Book
      </div>
      <div class="formarea">
        <el-form :inline="false" :model="form" :rules="rules" ref="ruleForm">
          <!-- divide into two columns -->
          <el-row :gutter="20">
            <el-col :span="12">
              <!-- first column -->
              <el-form-item label="ISBN: " prop="isbn">
                <el-input v-model="form.isbn" placeholder="Enter isbn" @change="selectBook"></el-input>
              </el-form-item>
              <el-form-item label="Name: " prop="name">
                <el-input v-model="form.name" placeholder="Enter name"></el-input>
              </el-form-item>
              <el-form-item label="Author: " prop="author">
                <el-input v-model="form.author" placeholder="Enter author"></el-input>
              </el-form-item>
              <el-form-item label="Publisher: " prop="publisher">
                <el-input v-model="form.publisher" placeholder="Enter publisher name"></el-input>
              </el-form-item>
              <el-form-item label="Publish Date: " prop="publish_date">
                <el-date-picker v-model="form.publish_date" type="date" value-format="yyyy-MM-dd"
                  placeholder="Select a date" style="width: 100%;"></el-date-picker>
              </el-form-item>
              <el-form-item label="Position: " prop="position">
                <el-select v-model="form.position" placeholder="Please Choose" style="width: 100%;">
                  <el-option label="Circulation Room" value="Circulation Room"></el-option>
                  <el-option label="Reading Room" value="Reading Room"></el-option>
                </el-select>
              </el-form-item>

            </el-col>
            <el-col :span="12">
              <!-- second column -->

              <el-form-item label="Category: ">
                <el-cascader :props="{ value: 'name', label: 'name' }" v-model="form.categories" :options="categories"
                  style="width: 100%;"></el-cascader>
              </el-form-item>
              <el-form-item label="Score: " prop="credit">
                <el-input v-model="form.credit" placeholder="Enter score value"></el-input>
              </el-form-item>
              <el-form-item label="Cover url: " prop="cover">
                <el-input v-model="form.cover" placeholder="Enter cover url"></el-input>
              </el-form-item>
              <el-form-item label="Number: " prop="number ">
                <el-input v-model="form.number" placeholder="1" :disabled="true"></el-input>
              </el-form-item>
              <el-form-item label="Status: " prop="status">
                <el-input v-model="form.status" placeholder="" :disabled="true"></el-input>
              </el-form-item>
              <el-form-item label="Handler: " prop="handler">
                <el-select v-model="form.handler" clearable filterable placeholder="Please select admin" 
                  style="width: 100%;">
                  <el-option v-for="item in admin" :key="item.email" :label="item.email" :value="item.email">
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="Description: " prop="description">
            <el-input style="width: 100%" type="textarea" v-model="form.description"
              placeholder="Enter description"></el-input>
          </el-form-item>
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

export default {
  name: "Add",
  data() {
    const checkNumeric = (rule, value, callback) => {
      if (!value) {
        callback(new Error('This blank cannot be empty'));
      }
      if (!/^[0-9]*$/.test(value)) {
        callback(new Error('Please enter a numerical value'))
      }
      if (parseInt(value) < 0) {
        callback(new Error('Please enter a number larger than 0'))
      }
      callback()
    }

    const checkISBN = (rule, value, callback) => {
      if (!value) {
        callback(new Error('Please enter the book\'s ISBN'))
      }
      if (!/^[0-9]{10}$/.test(value)) {
        callback(new Error('Illegal ISBN'));
      }
      callback()
    }

    return {
      form: {},
      books: [],
      admin: [],
      categories: [],
      rules: {
        // cannot be empty
        name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
        category: [{ required: true, message: "Please select the book's category", trigger: 'blur' }],
        author: [{ required: true, message: "Please enter the book's author", trigger: 'blur' }],
        publisher: [{ required: true, message: "Please enter the book's publisher", trigger: 'blur' }],
        publish_date: [{ required: true, message: "Please select a date", trigger: 'blur' }],
        //more restrictions
        isbn: [{ required: true, validator: checkISBN, trigger: 'blur' }],
        number: [{ required: true, validator: checkNumeric, trigger: 'blur' }],
        credit: [{ required: true, validator: checkNumeric, trigger: 'blur' }],
      }
    }
  },
  watch: {
    'form.position'(newValue) {
      if (newValue === 'Circulation Room') {
        this.form.status = 'Available';
      } else if (newValue === 'Reading Room') {
        this.form.status = 'Unavailable';
      }
    }
  },


  created() {
    request.get('category/tree').then(res => {
      this.categories = res.data
      // console.log(this.categories)
    })
    request.get("/book/list").then(res => {
      this.books = res.data
      // console.log(this.books)
    })
    request.get("/admin/list").then(res => {
      this.admin = res.data
      // console.log(this.admin)
    })
   

  },

  methods: {
    save() {
      // console.log(this.form)
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          request.post('bookUnity/save', this.form).then(res => {
            if (res.code === '200') {
              this.$notify.success('Submitted')
              this.$refs['ruleForm'].resetFields()
            } else {
              this.$notify.error(res.msg)
            }
          })
        }
      })
    },

    selectBook() {
      // console.log(this.form)
      const book = this.books.find(v => v.isbn === this.form.isbn)
      request.get("/book/" + book.isbn).then(res => {
        this.form = res.data
        if (this.form.category) {
          // console.log(this.form.category)
          this.form.categories = this.form.category.split(' > ')
          // console.log(this.form.categories)
          console.log(this.form.categories)

        }
        this.$forceUpdate()
      })
    }
  }
}
</script>

<style scoped lang="scss">
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