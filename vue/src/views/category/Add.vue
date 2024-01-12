<template>
  <div style="padding: 20px; display: flex; justify-content: center; align-items: center; height: 100%;">
    <div style="width: 60%; box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); padding: 20px; border-radius: 10px; color: white">
      <div
        style="font-size: 40px; font-family: 'Open Sans', sans-serif; color: #333; margin-bottom: 20px; text-align: center;">
        Add Parent Category</div>
      <el-form :model="form" :rules="rules" ref="ruleForm" style="width: 100%;">
        <el-form-item label="Category Name: " prop="name" style="width: 100%;">
          <el-input v-model="form.name" placeholder="Enter name" style="width: 100%;"></el-input>
        </el-form-item>
        <el-form-item label="Category Remark:  " prop="remark" style="width: 100%;">
          <el-input v-model="form.remark" placeholder="Enter remark" style="width: 100%;"></el-input>
        </el-form-item>
      </el-form>

      <div style="text-align: center; margin-top: 20px;">
        <el-button type="primary"
          style="height: 40px; min-width: 100px; border-radius: 5px; font-family: 'Open Sans', sans-serif;"
          @click="save">Submit</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Add",

  data() {
    return {
      form: {},
      rules: {
        name: [{ required: true, message: "Category name must not be empty", trigger: 'blur' }],
        remark: [{ required: true, message: "Remark must not be empty", trigger: 'blur' }],
      }
    }
  },

  methods: {
    save() {
      this.$refs['ruleForm'].validate((valid) => {
        if (valid) {
          request.post('category/save', this.form).then(res => {
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
  }
}
</script>

<style>
/* 通用CSS样式 */
body {
  font-family: 'Open Sans', sans-serif;
}

/* 按钮悬停效果 */
.el-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.2);
}
</style>