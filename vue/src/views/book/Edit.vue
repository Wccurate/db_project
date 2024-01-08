<template>
  <div>
    <div class="wrapper">
      <div class="fontarea">Edit Book</div>
      <div class="formarea">
        <!-- Form area -->
        <el-form :model="form" :rules="rules" ref="ruleForm">
          <el-row :gutter="20">
            <el-col :span="12">
              <!-- First column form items -->
              <el-form-item label="ISBN: " prop="isbn">
                <el-input v-model="form.isbn" placeholder="Enter isbn" disabled></el-input>
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
            </el-col>
            <el-col :span="12">
              <!-- Second column form items -->

              <el-form-item label="Category: " prop="category">
                <el-cascader :props="{ value: 'name', label: 'name' }" v-model="form.categories"
                  :options="categories" style="width: 100%;"></el-cascader>
              </el-form-item>
              <el-form-item label="Score: " prop="credit">
                <el-input v-model="form.credit" placeholder="Enter score value"></el-input>
              </el-form-item>
              <el-form-item label="Cover url: " prop="cover">
                <el-input v-model="form.cover" placeholder="Enter cover url"></el-input>
              </el-form-item>
              <el-form-item label="Number: " prop="number">
                <el-input v-model="form.number" placeholder="Enter number"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="Description: " prop="description">
            <el-input type="textarea" v-model="form.description" placeholder="Enter description"
              style="width: 100%;"></el-input>
          </el-form-item>
          <!-- Button area -->
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
  name: "Edit",

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
    };

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
      form: {
      },
      categories: [],
      rules: {
        // cannot be empty
        name: [{ required: true, message: "Please enter the book's name", trigger: 'blur' }],
        category: [{ required: true, message: "Please enter the book's category", trigger: 'blur' }],
        author: [{ required: true, message: "Please enter the book's author", trigger: 'blur' }],
        publisher: [{ required: true, message: "Please enter the book's publisher", trigger: 'blur' }],
        publish_date: [{ required: true, message: "Please select a date", trigger: 'blur' }],
        // more restrictions
        isbn: [{ required: true, validator: checkISBN, trigger: 'blur' }],
        number: [{ required: true, validator: checkNumeric, trigger: 'blur' }],
        credit: [{ required: true, validator: checkNumeric, trigger: 'blur' }],
      }
    }
  },

  created() {
    const isbn = this.$route.query.isbn
    request.get('category/tree').then(res => {
      this.categories = res.data
      // console.log(this.categories)
    })
    // console.log(isbn)
    request.get("/book/" + isbn).then(res => {
      this.form = res.data
      // console.log(this.form)
      if (this.form.category) {
        console.log(this.form.category)
        this.form.categories = this.form.category.split(' > ')
        console.log(this.form.categories)
      }
    })


  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          // console.log(this.form)
          request.put('book/update', this.form).then(res => {
            if (res.code === '200') {
              this.$notify.success('Updated')
              this.$router.push("/BookList")
            } else {
              this.$notify.error(res.msg)
            }
          })
        }
      })
    },
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