import axios from 'axios';
import Cookies from "js-cookie";
import router from "@/router";

const request = axios.create({
    // baseURL: 'http://192.168.213.136:8080',
    baseURL: 'http://localhost:8081',
    timeout: 5000
})

request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';

    //const admin = Cookies.get('admin');
    //if(!admin) {
    //    router.push('/login')
    //}

    return config
}, error => {
    return Promise.reject(error)
});

request.interceptors.response.use(
    response => {
        let res = response.data;
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        return res;
    },
    error => {
        console.log('err' + error) // for debug
        return Promise.reject(error)
    }
)


export default request