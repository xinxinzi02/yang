<template>
	<view>
		<!-- 搜索商家 -->
		<uni-search-bar  placeholder="请输入你想搜索的商家"   @confirm="search" ></uni-search-bar>
		<swiper circular autoplay :interval="3000" :duration="500" indicator-dots style="height: 360rpx;"
			indicator-color="rgba(255, 255, 255, 0.6)" indicator-active-color="#3CB371">
			<swiper-item v-for="item in banners" :key="item.id">
				<navigator :url="'/pages/detail/detail?businessId=' + item.businessId "  >
					<image :src="item.img" alt="" mode="widthFix" style="width: 100%;" />
					<!-- widthFix 保持图片的宽高比不变，等比例缩放 -->
				</navigator>
			</swiper-item>
		</swiper>
		<view style="padding: 20rpx;">
			<!-- 公告 -->
			<view class="box">
				<uni-icons type="sound" size="20" style="position: relative; top: 5rpx;"></uni-icons>
				<text style="margin-left: 5rpx;">{{ notice }}</text>
			</view>

			<!-- 商家分类 -->
			<view class="box" style="margin: 20rpx 0;">
				<view style="display: flex;">
					<view class="category-item" @click="goBusiness('奶茶饮品')">
						<image src="@/static/imgs/咖啡.png" mode="widthFix" style="width: 50%;"></image>
						<text>奶茶饮品</text>
					</view>
					<view class="category-item" @click="goBusiness('轻食简餐')">
						<image src="@/static/imgs/轻食.png" mode="widthFix" style="width: 50%;"></image>
						<text>轻食简餐</text>
					</view>
					<view class="category-item" @click="goBusiness('炸鸡汉堡')">
						<image src="@/static/imgs/汉堡.png" mode="widthFix" style="width: 50%;"></image>
						<text>炸鸡汉堡</text>
					</view>
					<view class="category-item" @click="goBusiness('特色美味')">
						<image src="@/static/imgs/美食.png" mode="widthFix" style="width: 50%;"></image>
						<text>特色美味</text>
					</view>
				</view>
			</view>


			<!-- 商家列表 -->
			<view class="box" style="color: orange;font-size: 32rpx;font-weight: bold;margin-bottom: 10rpx;"  >
				热门商家
			</view>

			<view class="box" v-for="item in businessList" :key="item.id"
				style="display: flex; grid-gap: 20rpx; margin-bottom: 10rpx;"  @click="goToDeatil(item.id)">
				<!-- grid-gap：定义栅格布局中行与列间隙的尺寸。 -->
				<view style="width: 30%;">
					<image :src="item.avatar"
						style="width: 100%; height: 200rpx; border-radius: 10rpx; display: block;"></image>
				</view>
				<view style="flex: 1; display: flex; flex-direction: column; justify-content: space-between; grid-gap: 10rpx;">
					<view style="font-size: 36rpx; font-weight: bold;">{{ item.name }}</view>

					<view style="display: flex;  color: #666; ">
						<view style="flex: 1;">
							<text style="color: #ff9800; font-weight: bold;">{{ item.score }}分</text>
							<text style="margin-left: 10rpx;">已售{{ item.nums  }}</text>
						</view>
						<view style="flex: 1; text-align: right;">30分钟内送达</text>
						</view>
					</view>

					<view style="color: #ff9800;">免配送费</view>

					<view style="background-color: #ffd281; color: brown; border-radius: 4rpx; width: fit-content;
				        padding: 0 8rpx;">{{ item.info || '商家介绍' }}</view>
						<!-- width: fit-content 用于设置元素的宽度，使其适应内容的尺寸，而不会超过父容器的宽度 -->

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
				banners: [],
				noticeList: [],
				notice: '',
				businessList: []
			}
		},
		onShow() {
			// http://localhost:9090/
			// this.$request.get('/banner/selectAll').then(res=>{
			// 	console.log(res,'请求得到的数据')
			// })
			this.load()

		},
		methods: {
			goBusiness(type){
				uni.navigateTo({
					url:'/pages/categoryBusiness/categoryBusiness?type=' + type
				})
				
			},
			search(res) {//搜索商家
            console.log(res,"搜索商家点击")
			  let value = res.value
			  uni.navigateTo({//将商家名称带过去
			    url: '/pages/search/search?name=' + value
			  })
			},
			goToDeatil(businessId) {
			  uni.navigateTo({
			    url: '/pages/detail/detail?businessId=' + businessId
			  })
			},
			load() {
				//获取轮播图的数据
				this.$request.get('/banner/selectAll').then(res => {
					this.banners = res.data || []
				})
				// 获取公告数据
				this.$request.get('/notice/selectAll').then(res => {
					this.noticeList = res.data || []
					if (this.noticeList.length) { //当后台传过来的noticeList(公告信息)不为空的时候才进行循环
						let i = 0
						this.notice = this.noticeList[i++].content //因为定时器有延迟，导致页面刷新出现无数据状态，所以在它执行之前先为它赋个值。
						if (this.noticeList.length > 1) {
							setInterval(() => { //(setInterval是定时器)每隔3000ms循环一次，i就进行加1
								if (i === this.noticeList.length) { //当i的值等于length的时候，说明list的数据已经遍历完了
									i = 0 //将i进行清空
								}
								this.notice = this.noticeList[i++]
									.content //i++,每隔3000ms依次从list中一个一个的取出数据放到notice里面
							}, 3000)
						}
					}
				})



				// 获取商家的列表
				this.$request.get('/business/selectAll', {status: '通过' }).then(res => {
					this.businessList = res.data || []
				})
			}
		}
	}
</script>

<style>
	.category-item {
		flex: 1;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;
		grid-gap: 10rpx;
	}
</style>