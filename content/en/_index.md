---
title: Liu TzuCheng's Doc Site
---

{{< blocks/cover title="Code & Thoughts" image_anchor="top" height="full" >}}
<p class="lead">Technical sharing and experience recording — in the cloud!</p>
<div style="margin-top: 40vh;"></div>
{{< blocks/link-down color="info" >}}
{{< /blocks/cover >}}

<!-- 调试信息显示区域 -->
<div id="debug-info" style="position: fixed; top: 10px; right: 10px; background: rgba(0,0,0,0.8); color: white; padding: 10px; border-radius: 5px; font-family: monospace; font-size: 12px; max-width: 300px; z-index: 1000;">
    <div>调试信息:</div>
    <div id="debug-content">正在加载...</div>
</div>

<script>
// 智能随机背景图片功能
(function() {
    'use strict';
    
    // 防止重复执行
    if (window.RandomBackgroundInitialized) {
        return;
    }
    window.RandomBackgroundInitialized = true;
    
    // 调试信息显示函数
    function showDebug(message) {
        const debugContent = document.getElementById('debug-content');
        if (debugContent) {
            const timestamp = new Date().toLocaleTimeString();
            debugContent.innerHTML += `<div>[${timestamp}] ${message}</div>`;
            console.log(message);
        }
    }
    
    // 配置参数
    const config = {
        username: 'pinyinjj',
        collectionId: '1954116',
        corsProxy: 'https://cors.bridged.cc/'
    };
    
    // 从收藏夹获取图片并随机选择一张
    async function getRandomBackgroundImage() {
        try {
            const apiUrl = `${config.corsProxy}https://wallhaven.cc/api/v1/collections/${config.username}/${config.collectionId}`;
            showDebug(`获取收藏夹图片: ${apiUrl}`);
            
            const response = await fetch(apiUrl, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const text = await response.text();
            const responseData = JSON.parse(text);
            
            if (responseData.data && responseData.data.length > 0) {
                // 提取所有图片路径
                const allPaths = responseData.data.map(item => item.path);
                showDebug(`获取到 ${allPaths.length} 张图片`);
                
                // 随机选择一张图片
                const randomIndex = Math.floor(Math.random() * allPaths.length);
                const selectedImage = allPaths[randomIndex];
                
                showDebug(`随机选择图片: ${selectedImage}`);
                return selectedImage;
            } else {
                showDebug('收藏夹中没有图片');
                return null;
            }
            
        } catch (error) {
            showDebug(`获取图片失败: ${error.message}`);
            return null;
        }
    }
    
    // 设置背景图片
    async function setRandomBackground() {
        const coverBlock = document.querySelector('.td-cover-block');
        if (coverBlock) {
            const randomImage = await getRandomBackgroundImage();
            
            if (randomImage) {
                coverBlock.style.backgroundImage = `url('${randomImage}')`;
                showDebug(`设置背景图片成功: ${randomImage}`);
            } else {
                showDebug('没有可用的背景图片');
            }
        }
    }
    
    // 公开的配置接口
    window.RandomBackground = {
        // 手动刷新背景
        refresh: function() {
            setRandomBackground();
        },
        // 隐藏调试信息
        hideDebug: function() {
            const debugInfo = document.getElementById('debug-info');
            if (debugInfo) {
                debugInfo.style.display = 'none';
            }
        },
        // 显示调试信息
        showDebug: function() {
            const debugInfo = document.getElementById('debug-info');
            if (debugInfo) {
                debugInfo.style.display = 'block';
            }
        }
    };
    
    // 只执行一次：页面加载完成后设置随机背景
    document.addEventListener('DOMContentLoaded', function() {
        showDebug('开始设置随机背景');
        setRandomBackground();
    });
    
})();
</script>

{{% blocks/section type="row" %}}
{{% blocks/feature icon="fab fa-weixin" title="WeChat Contact" url="https://your-wechat-link" %}}
Contact me via WeChat to share technical experiences and insights
{{% /blocks/feature %}}

{{% blocks/feature icon="fab fa-qq" title="QQ Contact" url="https://your-qq-link" %}}
Contact me via QQ to discuss technical issues and project collaboration
{{% /blocks/feature %}}

{{% blocks/feature icon="fab fa-github" title="Other Projects" url="https://github.com/pinyinjj" %}}

{{% /blocks/feature %}}

{{% /blocks/section %}}
