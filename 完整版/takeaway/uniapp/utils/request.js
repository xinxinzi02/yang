import apiConfig from '@/config.js'
const baseUrl = process.env.NODE_ENV === "development" ? apiConfig.dev.baseUrl : apiConfig.prod.baseUrl

const request = (options = {}) => {
    return new Promise((resolve, reject) => {
        uni.request({
            url: baseUrl + options.url || '',
            method: options.method || 'GET',
            data: options.data || {},
            header: options.header || {"Content-Type": "application/json", token: uni.getStorageSync('xm-user')?.token}  
		    //首先会先取出浏览器缓存的用户信息，其次接着取出用户信息下面的token信息，最后把token放到用户信息下面。(header里的token数据是怎么存储的)
			//登录不需要token，登录进去之后，所有的接口请求，都要把这个token带着
        }).then(res => {
			let { data } = res
			if (data.code === '401') {
				uni.navigateTo({
					url: '/pages/login/login'
				})
			}
            resolve(data);
        }).catch(error => {
            reject(error)
        })
    });
}

const get = (url, data, options = {}) => {
    options.method = 'GET'
    options.data = data
    options.url = url
    return request(options)
}

const post = (url, data, options = {}) => {
    options.method = 'POST'
    options.data = data
    options.url = url
    return request(options)
}

const put = (url, data, options = {}) => {
    options.method = 'PUT'
    options.data = data
    options.url = url
    return request(options)
}

const del = (url, data, options = {}) => {
    options.method = 'DELETE'
    options.data = data
    options.url = url
    return request(options)
}

export default  {
    request,
    get,
    post,
	put,
	del
}