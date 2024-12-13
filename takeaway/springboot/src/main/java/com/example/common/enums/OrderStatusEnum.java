package com.example.common.enums;

public enum OrderStatusEnum {


    /**
     * 已取消
     */
    CANCEL("已取消"),

    /**
     * 待支付状态
     */
    NO_PAY("待支付"),

    /**
     * 待发货
     */
    NO_SEND("待发货"),

    /**
     * 待收货
     */
    NO_RECEIVE("待收货"),

    /**
     * 待评价
     */
    NO_COMMENT("待评价"),

    /**
     * 已退款
     */
    MONEY_BACK("已退款"),

    /**
     * 已经完成
     */
    DONE("已完成");

    private String value;


    OrderStatusEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
