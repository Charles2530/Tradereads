<template>
  <div class="p-4">
    <el-card class="box-card">
      <div class="clearfix">
        <div class="grid place-items-center mb-8">
          <logo-info />
        </div>
        <h1 class="text-3xl text-center mb-6">我的钱包</h1>
        <div class="text-center mb-6">
          <p class="text-xl">
            <el-icon class="mr-2"><Coin /></el-icon>
            余额：{{ resMoney }}
          </p>
        </div>
      </div>
      <div class="text-center mb-2">
        <el-button
          class="text-white font-semibold hover:underline"
          type="primary"
          @click="showRechargeDialog = true"
          plain
        >
          <el-icon class="ml-1 mr-4"><ShoppingCart /></el-icon>
          充值</el-button
        >
        <el-button
          class="text-white font-semibold hover:underline"
          type="success"
          @click="showPaymentMethodDialog = true"
          plain
        >
          <el-icon class="ml-1 mr-4"><ShoppingBag /></el-icon>
          修改支付方式</el-button
        >
      </div>
    </el-card>

    <el-dialog title="充值" v-model="showRechargeDialog" width="15%">
      <el-input-number
        class="my-7"
        v-model="rechargeAmount"
        placeholder="充值金额"
        :precision="2"
        size="large"
      ></el-input-number>
      <div>
        <span class="dialog-footer">
          <el-button @click="showRechargeDialog = false">取消</el-button>
          <el-button type="primary" @click="recharge">充值</el-button>
        </span>
      </div>
    </el-dialog>

    <el-dialog
      title="修改支付方式"
      v-model="showPaymentMethodDialog"
      width="30%"
    >
      <el-form ref="paymentForm" :model="paymentMethod" label-width="120px">
        <el-form-item label="支付方式">
          <el-select v-model="paymentMethod.type" placeholder="请选择支付方式">
            <el-option label="银行卡" value="bank"></el-option>
            <el-option label="支付宝" value="alipay"></el-option>
            <el-option label="微信" value="wechat"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span class="dialog-footer flex justify-center">
        <el-button @click="showPaymentMethodDialog = false">取消</el-button>
        <el-button type="primary" @click="updatePaymentMethod">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { ref } from "vue";
import logoInfo from "@c/home/logoInfo.vue";
import { addMoney } from "@/api/wallet";
import { modify_payType } from "@/api/user";
import { ElMessage } from "element-plus";
import { userStore } from "@/store/user.js";
export default {
  name: "PersonalWallet",
  props: {
    resMoney: {
      type: Number,
      default: 300,
    },
  },
  setup() {
    const showRechargeDialog = ref(false);
    const showPaymentMethodDialog = ref(false);
    const store = userStore();
    const rechargeAmount = ref("");
    const paymentMethod = ref({
      type: "",
    });

    const recharge = () => {
      addMoney({ charge_money: rechargeAmount.value }).then((res) => {
        if (res.success) {
          console.log(`充值金额: ${rechargeAmount.value}`);
          ElMessage({
            message: "充值成功",
            type: "success",
          });
          location.reload();
        } else {
          ElMessage({
            message: "充值失败",
            type: "error",
          });
        }
      });
      showRechargeDialog.value = false;
    };

    const updatePaymentMethod = () => {
      modify_payType(store.getToken, {
        pay_type: paymentMethod.value.type,
      }).then((res) => {
        if (res.success) {
          console.log(`支付方式: ${paymentMethod.value.type}`);
          ElMessage({
            message: "修改成功",
            type: "success",
          });
          location.reload();
        } else {
          ElMessage({
            message: "修改失败",
            type: "error",
          });
        }
      });
      showPaymentMethodDialog.value = false;
    };

    return {
      showRechargeDialog,
      showPaymentMethodDialog,
      rechargeAmount,
      paymentMethod,
      recharge,
      updatePaymentMethod,
      logoInfo,
    };
  },
};
</script>

<style scoped></style>
