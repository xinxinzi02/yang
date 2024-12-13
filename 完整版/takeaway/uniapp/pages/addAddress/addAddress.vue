<template>
	<!-- 地址编辑页面 -->
	<view style="padding: 20rpx;">
		<view class="box">
			<uni-forms :modelValue="form" :rules="rules" ref="formRef" label-width="160rpx" label-align="right">
			  <uni-forms-item label="地址信息" name="address" required>
			    <uni-easyinput type="textarea" v-model="form.address" placeholder="请输入地址" />
			  </uni-forms-item>
			  <uni-forms-item label="联系人" name="user" required>
			    <uni-easyinput type="text" v-model="form.user" placeholder="请输入联系人" />
			  </uni-forms-item>
			  <uni-forms-item label="联系方式" name="phone" required>
			    <uni-easyinput type="text" v-model="form.phone" placeholder="请输入联系方式" />
			  </uni-forms-item>
			
			  <uni-forms-item>
			    <button type="primary" size="mini" @click="saveAddress">保 存</button>
			  </uni-forms-item>
			</uni-forms>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: uni.getStorageSync('xm-user'),
				form: {},
				rules: {//表达校验规则
				  address: {
				    rules: [{
				      required: true,
				      errorMessage: '请填写地址',
				    }]
				  },
				  user: {
				    rules: [{
				      required: true,
				      errorMessage: '请填写联系人',
				    }]
				  },
				  phone: {
				    rules: [{
				      required: true,
				      errorMessage: '请填写联系方式',
				    }]
				  }
				}
			}
		},
		onLoad(option) {
			let addressId = option.addressId || 0   //接收address传过来的addressId
			
			if (addressId > 0) {
				this.$request.get('/address/selectById/' + addressId).then(res => {
					this.form = res.data || {}  //请求地址的数据
				})
			}
		},
		methods: {
			saveAddress() {
				// 验证
				this.$refs.formRef.validate().then(res => {
				  this.$request.request({
					  method: this.form.id ? 'PUT' : 'POST',//判断form.id是否有值，有值的话调put，没有值的话调post
					  url: this.form.id ? '/address/update' : '/address/add',//同上
					  data: this.form
				  }).then(res => {
				    if (res.code === '200') {
				      uni.showToast({
				        title: '操作成功'
				      })
					  uni.navigateBack()//保存成功地址后，返回前一个页面
				    } else {
				      uni.showToast({
				        icon: 'error',
				        title: res.msg
				      })
				    }
				  })
				}).catch(err => {
				  console.log('err', err);
				})  
			}
		}
	}
</script>

<style>

</style>
