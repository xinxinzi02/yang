<template>
	<view style="padding: 40rpx;">
		<view
			style="padding: 20rpx; margin: 80rpx 0; background-color: #fff; box-shadow: 2rpx  5rpx 10rpx 10rpx rgba(0,0,0,.1); border-radius: 10rpx;">
			<view style="margin: 50rpx 30rpx; font-size: 40rpx;">欢迎登录</view>
			<uni-forms ref="form" :modelValue="form" :rules="rules" validateTrigger='blur'>
				<!-- 一， :rules="rules 绑定规则   二， 在uni-forms-item上写上 name 表示这个规则的应用范围 列如: name="username" -->
				<!-- validateTrigger='blur' 表示规则的触发时机 两种规则blur/ submit  submit提交的时候校验-->
				<uni-forms-item name="username" required>
					<uni-easyinput prefixIcon="person" v-model="form.username" placeholder="请输入账号" />
				</uni-forms-item>
				<uni-forms-item name="password" required>
					<uni-easyinput  type="password" prefixIcon="locked" v-model="form.password" placeholder="请输入密码" />
				</uni-forms-item>
				<uni-forms-item>
					<button @click="login()"
						style="background-color: #ffd100; border-color: #ffd100; height: 70rpx; line-height: 70rpx;">登
						录</button>
				</uni-forms-item>
				<uni-forms-item>
					<view style="text-align: right;margin-right: 20rpx">还没有账号？去 <navigator style="display: inline-block; color: dodgerblue; 
						margin-left: 4rpx;" url="/pages/register/register">注册</navigator>
					</view>
				</uni-forms-item>
			</uni-forms>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				form: {
					role: 'USER' //默认角色
				},
				rules: {
					// 对username字段进行必填验证
					username: {
						// username 字段的校验规则
						rules: [
							// 校验 username 不能为空
							{
								required: true,
								errorMessage: '请输入账号',
							},
							// 对username字段进行长度验证
							{
								minLength: 3,
								maxLength: 10,
								errorMessage: '账号长度在 {minLength} 到 {maxLength} 个字符',
							}
						],
					},
					password: {
						rules: [{
								required: true,
								errorMessage: '请输入密码',
							},
							{
								minLength: 3,
								maxLength: 10,
								errorMessage: '密码长度在 {minLength} 到 {maxLength} 个字符',
							}
						],
					}
				}
			}
		},
		methods: {
			login() {
				this.$refs.form.validate().then(res => { //提交之前进行校验
					this.$request.post('/login', this.form).then(res => {
						if (res.code === '200') {
							uni.showToast({
								icon: 'success',
								title: '登录成功'
							})
							//登录成功时，存储用户信息
							uni.setStorageSync('xm-user', res.data)


							setTimeout(() => { //延时跳转，500ms之后在进行跳转
								// 跳转主页
								uni.switchTab({
									//注意不能使用navigateTo，因为你的主页是菜单栏，你不能通过navigateTo 这样的方式去跳转
									//应该通过这个方式去跳转
									url: '/pages/index/index'
								})
							}, 500)



						} else { //提示消息
							uni.showToast({
								icon: 'error',
								title: res.msg
							})
						}
					})
				}).catch(err => {
					console.log('输入信息错误：', err);
				})
			}
		}
	}
</script>

<style>

</style>