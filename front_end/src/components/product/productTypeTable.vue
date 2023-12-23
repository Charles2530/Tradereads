<template>
  <div class="w-full h-full">
    <p class="text-2xl mb-4 flex justify-center">商品分类统计图</p>
    <div ref="chart" class="w-full h-full min-h-[400px]"></div>
  </div>
</template>

<script>
import { ref, onMounted, onUpdated, nextTick } from "vue";
import * as echarts from "echarts";

export default {
  props: {
    statistics: {
      type: Array,
      required: true,
    },
  },
  setup(props) {
    const chartInstance = ref(null);
    const chart = ref(null);
    console.log(props.statistics);

    const initChart = () => {
      nextTick(() => {
        console.log(chart.value);
        if (chart.value) {
          chartInstance.value = echarts.init(chart.value);
          updateChart();
        }
      });
    };

    const updateChart = () => {
      if (!chartInstance.value) return;

      const legendData = props.statistics.map((item) => item.name);
      const seriesData = props.statistics.map((item) => ({
        name: item.name,
        value: item.value,
      }));

      const option = {
        tooltip: {
          trigger: "item",
          formatter: "{b}: {c} ({d}%)",
        },
        legend: {
          orient: "vertical",
          left: "left",
          data: legendData,
        },
        series: [
          {
            type: "pie",
            radius: "90%",
            center: ["50%", "50%"],
            data: seriesData,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
            },
          },
        ],
      };

      chartInstance.value.setOption(option);
    };

    onMounted(() => {
      initChart();
    });

    onUpdated(() => {
      updateChart();
    });
    window.addEventListener("resize", () => {
      if (chartInstance.value) {
        chartInstance.value.resize();
      }
    });

    return {
      chartInstance,
      chart,
    };
  },
};
</script>

<style scoped>
/* 添加 Tailwind CSS 类或自定义样式 */
</style>
