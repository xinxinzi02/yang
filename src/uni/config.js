// 区分线上还是本地
const apiConfig = {
	dev: {
		//本地
		baseUrl:'http://localhost:9090'
	},
	prod: {
		//线上
		baseUrl:'http://:9090'
	}
}

export default apiConfig