"use strict";(self["webpackChunkvue"]=self["webpackChunkvue"]||[]).push([[548],{6548:function(e,t,r){r.r(t),r.d(t,{default:function(){return u}});var a=function(){var e=this,t=e._self._c;return t("div",{staticStyle:{padding:"10px"}},[e._m(0),t("div",{staticStyle:{width:"60%","margin-top":"2px"}},[t("el-form",{ref:"ruleForm",attrs:{inline:!0,model:e.form,rules:e.rules}},[t("el-form-item",{staticStyle:{"margin-left":"2px"},attrs:{label:"Category Name: ",prop:"name"}},[t("el-input",{attrs:{placeholder:"Enter name"},model:{value:e.form.name,callback:function(t){e.$set(e.form,"name",t)},expression:"form.name"}})],1),t("el-form-item",{staticStyle:{"margin-left":"2px"},attrs:{label:"Remark: ",prop:"remark"}},[t("el-input",{attrs:{placeholder:"Enter remark"},model:{value:e.form.remark,callback:function(t){e.$set(e.form,"remark",t)},expression:"form.remark"}})],1)],1),t("div",{staticStyle:{"text-align":"center"}},[t("el-button",{staticStyle:{"margin-left":"2px",height:"40px","min-width":"100px"},attrs:{type:"primary"},on:{click:e.save}},[e._v("Submit")])],1)],1)])},i=[function(){var e=this,t=e._self._c;return t("div",[t("div",{staticStyle:{"font-size":"40px","font-family":"Arial","margin-bottom":"5px"}},[e._v("Add Parent Category")])])}],l=r(4471),m={name:"Add",data(){return{form:{},rules:{name:[{required:!0,message:"Category name must not be empty",trigger:"blur"}],remark:[{required:!0,message:"Remark must not be empty",trigger:"blur"}]}}},methods:{save(){this.$refs["ruleForm"].validate((e=>{e&&l.Z.post("category/save",this.form).then((e=>{"200"===e.code?(this.$notify.success("Submitted"),this.$refs["ruleForm"].resetFields()):this.$notify.error(e.msg)}))}))}}},s=m,n=r(1001),o=(0,n.Z)(s,a,i,!1,null,"9d0bfebe",null),u=o.exports}}]);
//# sourceMappingURL=548.0ca107d2.js.map