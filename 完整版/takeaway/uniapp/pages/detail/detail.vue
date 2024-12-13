<template>
	<!-- 订单详情 -->
	<view style="padding: 20rpx;">
		<!-- 商家信息 -->
		<view class="box" style="display: flex;">
			<view style="flex: 1; display: flex; flex-direction: column; justify-content: space-between;">
				<view style="font-size: 36rpx; font-weight: bold;">
					<text>{{ business.name || '' }}</text>
					<uni-icons type="star-filled" size="18" color="orange" style="margin-left: 20rpx;"
						v-if="business.isCollect" @click="saveCollect()"></uni-icons>
					<uni-icons type="star-filled" size="18" color="#999" style="margin-left: 20rpx;" v-else
						@click="saveCollect()"></uni-icons>
				</view>
				<view>
					<text style="padding-right: 10rpx; border-right: 2rpx solid #ccc;">平台配送</text>
					<!-- solid #ccc;灰色的线 -->
					<text style="padding: 0 10rpx; border-right: 2rpx solid #ccc;">免配送费</text>
					<text style="padding: 0 10rpx;">30分钟送达</text>
				</view>
				<view>
					地址：{{ business.address || '' }}
				</view>
				<view>
					联系电话：{{ business.phone || '' }}
				</view>
			</view>

			<view style="width: 200rpx; height: 200rpx;">
				<image :src="business.avatar" style="width: 100%; height: 100%; border-radius: 50%;"></image>
			</view>
		</view>
		<!-- 商家信息结束 -->

		<!-- 商家的分类商品列表 -->
		<view style="margin: 20rpx 0;">
			<!-- 商家的分类商品列表header -->
			<view
				style="background-color: #fff; display: flex; border-radius: 10rpx; overflow: hidden; margin-bottom: 10rpx;">
				<!-- overflow: hidden; 表示当元素的内容超出容器的尺寸时，超出的部分将被隐藏，而不会显示在容器之外。 -->
				<view style="padding: 10rpx;" :class="{'active': current === '全部商品'}" @click="current = '全部商品'">全部商品
				</view>
				<!-- 当current是全部商品的时候，则全部商品高亮，当点击评价的时候，current重新赋值为评价，则评价高亮，全部商品反之 -->
				<view style="padding: 10rpx; width: fit-content;" :class="{'active': current === '评价'}"
					@click="current = '评价'">评价</view>
			</view>

			<!-- 商品分类测边栏展示 -->
			<view v-if="current === '全部商品'"
				style="display: flex; background-color: #fff; border-radius: 10rpx; padding: 10rpx;">
				<view style="width: 200rpx; text-align: center;">
					<view v-for="item in categoryList" :key="item.id" class="category-item"
						:class="{ 'category-active' : item.id === activeCategoryId }" @click="loadGoods(item.id)">
						<!-- 动态绑定class 条件是:当前的item.id = 我们选中的activeCategoryId -->
						{{ item.name }}
					</view>
				</view>


				<!-- 商品展示 -->
				<scroll-view scroll-y="true" style="height: calc(100vh - 480rpx);">
					<!-- 商品太多怎么实现滚动  窗口的固定高度是70%，商品一旦很多就会有滚动效果 -->
					<!-- 商品列表展示开始 -->
					<view style="padding: 20rpx;">
						
						
						<view style="display: flex; grid-gap: 20rpx; margin-bottom: 20rpx;" v-for="item in goodsList"
							:key="item.id">
							<view style="width: 200rpx; height: 200rpx;">
								<image :src="item.img"
									style="width: 200rpx; height: 200rpx; border-radius: 10rpx; display: block;">
								</image>
							</view>
							<view
								style="flex: 1; display: flex; flex-direction: column; justify-content: space-between;">
								<view style="font-size: 32rpx; font-weight: bold;">{{ item.name }}</view>
								<view style="font-size: 24rpx;">{{ item.descr }}</view>
								<view>
									<text class="mini-btn">{{ item.discount }}折</text>
									<text style="font-size: 24rpx; margin-left: 10rpx;">已售 {{ item.saleCount }}</text>
								</view>
								<view>
									<text style="text-decoration: line-through;">￥{{ item.price }}</text>
									<text style="color: orangered; margin-left: 10rpx;">￥{{ item.actualPrice}}</text>
									<text class="mini-btn" style="margin-left: 5rpx;">到手价</text>
								</view>
								<view>
									<text class="mini-btn-fill" @click="addCart(item)">选购</text>
								</view>
							</view>
						</view>
					
					
					</view>
				</scroll-view>
			</view>
			<!-- 商品列表结束 -->

			<!-- 评价列表 -->
			<scroll-view scroll-y="true" style="height: calc(100vh - 480rpx);" v-if="current === '评价'">
				<view class="box">
					<view v-for="item in commentList" :key="item.id"
						style="border-bottom: 2rpx solid #eee; padding: 20rpx 0;">
						<view style="display: flex; grid-gap: 20rpx;">
							<view style="display: flex; flex-direction: column; align-items: center; grid-gap: 10rpx;">
								<image :src="item.userAvatar" style="width: 120rpx; border-radius: 50%;"
									mode="widthFix"></image>
								<view>{{ item.userName }}</view>
							</view>
							<view
								style="flex: 1; display: flex; flex-direction: column; justify-content: space-between;">
								<view style="flex: 1; padding-top: 10rpx; font-size: 24rpx;">{{ item.content }}</view>
								<uni-rate :value="item.star" readonly></uni-rate>
							</view>
							<view style="font-size: 24rpx; color: #888; display: flex; align-items: flex-end;">
								{{ item.time }}</view>
						</view>
					</view>
				</view>
			</scroll-view>
			<!-- 评价列表结束 -->
		</view>
		<!-- 商家的分类商品列表结束 -->

		<!-- 购物车图标 -->
		<uni-goods-nav :fill="true" :options="options" :buttonGroup="buttonGroup" @click="onClick"
			@buttonClick="buttonClick" />

		<!-- 点击购物车图标弹出购物车商品列表 -->
		<uni-popup ref="popup" type="bottom" background-color="#fff">
			<scroll-view style="max-height: 70vh;" scroll-y="true">
				<view style="padding: 40rpx 40rpx 140rpx 40rpx;">
					<view style="text-align: right; margin-bottom: 10rpx; color: #999;" v-if="cartList.length">
						<uni-icons style="position: relative; top: 4rpx;" type="trash" size="16" color="#999"
							@click="deleteAll">
							清空
						</uni-icons>

					</view>
					<view v-for="(item, index) in cartList" :key="index" style="display: flex; margin-bottom: 20rpx;"
						v-if="item.goods">
						<view style="width: 100rpx; height: 100rpx;">
							<image style="width: 100%; height: 100%; display: inline-block;" :src="item.goods.img">
							</image>
						</view>
						<view
							style="flex: 1; margin-left: 20rpx; display: flex; flex-direction: column; justify-content: space-around;">
							<view style="flex: 1;">{{ item.goods.name }}</view>
							<view style="flex: 1; color: red; display: flex; align-items: flex-end;">
								<view style="flex: 1;">￥{{ item.goods.actualPrice }}</view>
								<view style="flex: 1; display: flex; justify-content: right;">
									<uni-number-box :min="1" v-model="item.num"
										@change="updateCart(item)"></uni-number-box>
								</view>
							</view>
						</view>
					</view>

					<view style="margin-top: 40rpx; text-align: right;" v-if="amount.amount">
						总金额：<text>￥{{ amount.amount }}</text></view>
					<view style="margin-top: 10rpx; text-align: right;" v-if="amount.discount">优惠金额：<text
							style="color: red;">-￥{{ amount.discount }}</text></view>
					<view style="margin-top: 10rpx; text-align: right;" v-if="amount.actual">实付金额：<text
							style="color: red; font-size: 32rpx;">￥{{ amount.actual }}</text></view>
				</view>
			</scroll-view>
		</uni-popup>


	</view>
</template>

<script>
	export default {
		data() {
			return {
				businessId: 0, //商家id
				business: {}, //商家
				categoryList: [], //商品分类信息
				activeCategoryId: 0, //被选中的商品分类信息
				goodsList: [], //商品列表
				current: '全部商品',
				options: [{
					icon: 'cart',
					text: '购物车',
					info: 0
				}],
				buttonGroup: [{
					text: '立即下单',
					backgroundColor: 'linear-gradient(90deg, #FE6035, #EF1224)',
					color: '#fff'
				}],
				user: uni.getStorageSync('xm-user'), //从登录后的浏览器中的仓库中取出用户的信息。
				cartList: [],
				amount: {},
				commentList:[],
			}
		},
		onShow() { //在订单确认页面返回的时候要刷新购物车的信息
			let allPages = getCurrentPages() //获取当前页面栈的实例；
			let lastPages = allPages.length - 1 // 获得倒数第二个元素的索引；
			let option = allPages[lastPages].options // 获得上个页面传递的参数；
			this.businessId = option.businessId
			this.load()
			this.loadCart() //页面加载的时候将购物车的数据加载出来
		},
		methods: {
			saveCollect() { //添加收藏
				this.$request.post('/collect/saveCollect', {
					userId: this.user.id,
					businessId: this.businessId
				}).then(res => {
					if (res.code === '200') {
						uni.showToast({
							icon: 'success',
							title: '操作成功'
						})
						this.load()
					} else {
						uni.showToast({
							icon: 'error',
							title: res.msg
						})
					}
				})
			},
			buttonClick() { //立即下单
				if (this.cartList.length === 0) { //购物无商品的时候不允许下单   
					uni.showToast({
						icon: 'none',
						title: '请选择商品'
					})
					return
				}
				let xmOrders = uni.getStorageSync('xm-orders') || {} //先获取出数据来
				xmOrders.businessId = this.businessId
				uni.setStorageSync('xm-orders', xmOrders)
				uni.navigateTo({ //传递参数 businessId  点击立即下单的时候，将该商家的id传到订单页面
					url: '/pages/confirm/confirm'

				})
			},
			deleteAll() { //情况购物车
				this.$request.del('/cart/deleteByBusiness/' + this.businessId + '/' + this.user.id).then(res => {
					if (res.code === '200') {
						uni.showToast({
							icon: 'success',
							title: '操作成功'
						})
						this.loadCart()
					} else {
						uni.showToast({
							icon: 'error',
							title: res.msg
						})
					}
				})
			},
			updateCart(cart) { //更新后台的cart的数据  比如点击+，购物车数量加一，需要将数据更新到后台
				this.$request.put('/cart/update', cart).then(res => {
					if (res.code === '200') {
						this.loadCart() //更新一下购物车图标的数字和cartList

					} else {
						uni.showToast({
							icon: 'error',
							title: res.msg
						})
					}
				})
			},
			onClick() {
				// 点击购物车图标触发
				this.$refs.popup.open('bottom')


			},
			loadCart() { //刷新购物车
				this.$request.get('/cart/selectAll', {
					userId: this.user.id, //查询，这个用户在这个商家所有购物车的列表
					businessId: this.businessId //筛选商家的购物车商品，保证在不同商家时，购物车的内容不一样
				}).then(res => {
					this.cartList = res.data || []
					this.options[0].info = this.cartList.length //购物车小图标的上的数字 = 购物车列表的长度
					console.log(this.cartList, "获取到的购物车列表")
				})

				this.$request.get('/cart/calc', {
					userId: this.user.id,
					businessId: this.businessId
				}).then(res => { //获取商品金额信息
					this.amount = res.data || {}
					console.log(this.amount, "获取商品德所有金额信息")
				})
			},
			addCart(goods) { //点击加购的时候
				this.$request.post('/cart/add', {
					goodsId: goods.id, //商品id
					num: 1, //数量
					businessId: this.businessId, //商家id
					userId: this.user.id //用户id
				}).then(res => {
					if (res.code === '200') {
						uni.showToast({
							icon: 'success',
							title: '加入成功'
						})
						this.loadCart() //重新加载购物车列表
					} else {
						uni.showToast({
							icon: 'error',
							title: res.msg
						})
					}
				})
			},
			load() {
				this.$request.get('/business/selectById/' + this.businessId).then(res => {
					this.business = res.data || {}
					console.log(this.business)
				})

				this.$request.get('/category/selectAll', {
					businessId: this.businessId //将商家id传给后台
				}).then(res => {
					this.categoryList = res.data || [] //从后台拿到该商家的商品分类信息
					this.activeCategoryId = this.categoryList.length > 0 ? this.categoryList[0].id : 0 //默认显示商品分类
					//如果categoryList.length > 0，即是后台传过来的分类列表有数据的时候，将列表中下标为0的，也就是第一个商品分类信息默认展示出来
					this.loadGoods(this.activeCategoryId)
				})

				this.$request.get('/comment/selectAll', {
					userId: this.user.id,
					businessId: this.businessId
				}).then(res => { //查询出用户自己的评论信息
					this.commentList = res.data || []
					console.log(this.commentList, "获取评价列表")
				})
			},
			
			
			loadGoods(categoryId) { //当点击商品分类的信息的时候，则会更新当前商品分类下边的所有商品信息
				console.log("我被点击1", categoryId)
				this.activeCategoryId = categoryId //将点击的商品分类categoryId传给你activeCategoryId
				console.log("我被点击2", this.activeCategoryId)
				this.$request.get('/goods/selectAll', {
					categoryId: categoryId //根据当前的商品分类id请求数据
				}).then(res => {
					console.log(res,"我是商品信息列表")
					this.goodsList = res.data || []
				})
			}
		}

	}
</script>

<style>
	.category-item {
		padding: 15rpx;
		background-color: #eee;
		border-bottom: 2rpx solid #fff;
	}

	.category-active {
		background-color: #fff;
		color: orange;
		border-left: 5rpx solid orange;
		/* 左边框变成橘色     solid是边框的样式，表示边框是实线的。*/
	}

	.mini-btn {
		border: 2rpx solid orangered;
		padding: 0 4rpx;
		font-size: 22rpx;
		color: orangered;
		border-radius: 5rpx;
		font-weight: bold;
	}

	.mini-btn-fill {
		background-color: orange;
		padding: 0 4rpx;
		color: #fff;
		font-size: 24rpx;
		border-radius: 5rpx;

	}

	.active {
		background-color: #ffd100;
	}
</style>