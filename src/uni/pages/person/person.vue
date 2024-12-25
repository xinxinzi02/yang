<template>
	<view style="padding: 20rpx;">
		<view class="box">
			<uni-forms :modelValue="form" :rules="rules" ref="formRef" label-width="140rpx" label-align="right">
				<uni-forms-item label="头像" name="avatar">
					<uni-file-picker limit="1" :image-styles="imageStyles" :del-icon="false" :disable-preview="true"
					 fileMediatype="image" v-model="avatar" @select="handleAvatarUploadSuccess">
						<!-- 配置 limit 属性为 1 ，则最多选择一张图片配置 mode 属性为 grid ，可以使用九宫格样式选择图片 -->
						<!-- 配置 disable-preview 属性为 true，禁用点击预览图片功能.配置 del-icon 属性为 false，隐藏删除按钮 -->
					</uni-file-picker>
				</uni-forms-item>
				<uni-forms-item label="账号" name="username">
					<uni-easyinput type="text" v-model="form.username" placeholder="" disabled />
				</uni-forms-item>
				<uni-forms-item label="姓名" name="name">
					<uni-easyinput type="text" v-model="form.name" placeholder="请输入姓名" />
				</uni-forms-item>
				<uni-forms-item label="性别" name="sex">
					<uni-data-checkbox style="position: relative; top: 10rpx;" v-model="form.sex" :localdata="range"></uni-data-checkbox>
				</uni-forms-item>
				<uni-forms-item label="电话" name="phone">
					<uni-easyinput type="text" v-model="form.phone" placeholder="请输入电话" />
				</uni-forms-item>
				
				<uni-forms-item>
					<button type="primary" size="mini" @click="save">保 存</button>
				</uni-forms-item>
			</uni-forms>
		</view>
	</view>
</template>

<script>
	export default{
		data(){
			return{
				avatar:[],
				form:{},
				user: uni.getStorageSync('xm-user'),
				imageStyles:{
					//头像框样式
					"height":80,
					"width":80,
					"border":{
						//边框样式
						"color":"#eee",
						"width":"1px",
						"style":"solid",
						"radius":"50%"
					}
				},
				range:[
					{ text: '男', value: '男' },
					{ text: '女', value: '女' },
			
				]
			}
		},
		onLoad(){
			this.form = JSON.parse(JSON.stringify(this.user))
			this.avatar = [{
				url:this.user.avatar
			}]
		},
		methods:{
			save(){
				this.$request.put('user/update',this.form).then(res => {
					if(res.code === '200'){
						uni.showToast({
							icon:"success",
							title:'操作成功'
						}) 
						uni.setStorageSync('xm-user',this.form)
					}else{
						uni.showToast({
							icon:"error",
							title:res.msg
						})
					}
				})
			},
			handleAvatarUploadSuccess(e) {//返回上传图片的地址（回调函数
				let _this = this //此页面有this，回调函数也有this，作以区分
				const filePath = e.temFilePaths[0]//暂时取出数据
				uni.uploadFile({
					url:_this.$baseUrl + 'files/upload',//自己的后端接口（默认发送post请求）
					filePath: filePath,
					name:"file",//这里应为自己后端文件形参的名字
					success(res){
						console.log(res)
						let url = JSON.parse(res.data || '{}').data
						_this.form.avatar = url
					}
				})
			}
		}
	}
</script>

<style>
</style>