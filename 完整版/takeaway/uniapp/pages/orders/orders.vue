<template>
	<view>
		<uni-segmented-control :current="current" :values="items" @clickItem="onClickItem" styleType="text"
			activeColor="#ff9900"></uni-segmented-control>
		<view style="padding: 20rpx;">

			<!-- 订单页面也会变化 1  v-for="item in ordersList"     ordersList 是跟随 current 变化的-->
			<view class="box" v-for="item in ordersList" :key="item.id" style="margin-bottom: 10rpx;"  >
				<view style="display: flex; align-items: baseline; margin-bottom: 10rpx;">
					<navigator :url="'/pages/detail/detail?businessId=' + item.businessId"
						style="flex: 1; font-size: 32rpx; ">{{ item.businessName }}
						<uni-icons type="right" size="16" color="#666"
							style="position: relative; top: 2rpx;"></uni-icons>
					</navigator>
					<view style="font-size: 24rpx; color: #666;">{{ item.status }}</view>
				</view>
				<!-- 订单页面的跳转不能放在整个订单信息卡片上，要放在中间的区域，防止误操作    @click="goOrdersItem(item.id)"-->
				<view style="display: flex; align-items: center; grid-gap: 20rpx; margin-bottom: 10rpx;" @click="goOrdersItem(item.id)">
					<view>
						<image style="display: block; width: 160rpx; height: 160rpx; border-radius: 10rpx;"
							:src="item.cover"></image>
					</view>
					<view style="flex: 1;">{{ item.name }}</view>
					<view>实付￥<text style="font-size: 36rpx; font-weight: bold; color: red;">{{ item.actual }}</text>
					</view>
				</view>
				<view style="display: flex; min-height: 40rpx;">
					<view style="flex: 1;">
						<view v-if="item.status === '已取消' || item.status === '已完成' || item.status === '已退款'"
							@click="del(item.id)">
							<!-- 删除图标 -->
							<uni-icons type="trash" size="16" color="#666"
								style="position: relative; top: 2rpx;"></uni-icons>
							<text style="font-size: 24rpx; color: #666;">删除</text>
						</view>
					</view>
					<view style="flex: 1; text-align: right;">
						<uni-tag v-if="item.status === '待支付'" text="支付" size="mini" type="primary"
							@click="changeStatus(item, '待发货')"></uni-tag>
						<uni-tag v-if="item.status === '待发货'" text="申请退款" size="mini" type="error"
							@click="changeStatus(item, '已退款')"></uni-tag>
						<uni-tag v-if="item.status === '待收货'" text="确认收货" size="mini" type="warning"
							@click="changeStatus(item, '待评价')"></uni-tag>
						<uni-tag v-if="item.status === '待评价'" text="评价" size="mini" type="royal" @click="goComment(item.id)"></uni-tag>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				current: 0,
				items: ['全部', '进行中', '待评价', '已退款'],
				ordersList: [],
				user: uni.getStorageSync('xm-user')
			}
		},
		onShow() { //订单页面的加载时机 页面一出现就加载
			this.loadOrders()
		},
		methods: {
			goComment(orderId){
				uni.navigateTo({
					url:"/pages/comment/comment?orderId=" + orderId
				})
			},
			goOrdersItem(orderId){
				uni.navigateTo({
					url:"/pages/ordersItem/ordersItem?orderId=" + orderId
				})
			},
			del(orderId) { //删除订单点击
				this.$request.del('/orders/delete/' + orderId).then(res => {
					if (res.code === '200') {
						uni.showToast({
							icon: "success",
							title: '操作成功'
						})
						this.loadOrders()
					} else {
						uni.showToast({
							icon: "error",
							title: res.msg
						})
					}
				})
			},
			changeStatus(orders, status) { //确认收货点击
				let form = JSON.parse(JSON.stringify(orders)) //进行深拷贝
				form.status = status //将现在的状态传给form里面的status里
				this.$request.put('/orders/update', form).then(res => {
					if (res.code === '200') {
						uni.showToast({
							icon: "success",
							title: '操作成功'
						})
						this.loadOrders() //重新加载订单信息
					} else {
						uni.showToast({
							icon: "error",
							title: res.msg
						})
					}
				})
			},
			loadOrders() {
				let status = '全部'
				switch (this.current) { //this.current会导致ordersList的变化,然后订单页面也会变化  1  ordersList 是跟随 current 变化的
					case 0:
						status = '全部';
						break
					case 1:
						status = '进行中';
						break
					case 2:
						status = '待评价';
						break
					case 3:
						status = '已退款';
						break
				}
				// 将上面switch中的status传递给后台，进行查询
				this.$request.get('/orders/selectAll', {
					userId: this.user.id,
					status: status
				}).then(res => {
					this.ordersList = res.data || []
				})
			},
			onClickItem(e) {
				if (this.current != e.currentIndex) {
					this.current = e.currentIndex;
					this.loadOrders()
				}
			}
		}
	}
</script>

<style>

</style>