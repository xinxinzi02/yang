// 这个js目的是为了区分本地ip和线上的ip
const apiConfig = {
	dev: {
		baseUrl: 'http://localhost:9090'//本地的ip地址配置    本地的后台请求
	},
	prod: {
		baseUrl: 'http://:9090'//线上的ip地址配置      线上的后台请求
	}
}

export default apiConfig