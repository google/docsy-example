// 智能随机背景图片功能
(function() {
    'use strict';
    
    // 配置参数
    const config = {
        // 你的用户名和收藏夹ID
        username: 'pinyinjj',
        collectionId: '1954116',
        // 备用图片列表（当API不可用时使用）
        fallbackImages: [
            'https://w.wallhaven.cc/full/3q/wallhaven-3q9qky.png',
            'https://w.wallhaven.cc/full/gw/wallhaven-gwjq3d.jpg'
        ]
    };
    
    // 从收藏夹获取图片
    async function fetchCollectionImages() {
        try {
            // 构建正确的API URL格式
            let apiUrl = `https://wallhaven.cc/api/v1/collections/${config.username}/${config.collectionId}`;
            
            console.log('正在获取收藏夹图片:', apiUrl);
            
            const response = await fetch(apiUrl);
            const data = await response.json();
            
            if (data.data && data.data.length > 0) {
                // 提取图片路径
                const images = data.data.map(item => item.path);
                console.log(`从收藏夹获取到 ${images.length} 张图片:`, images);
                return images;
            } else {
                console.log('收藏夹中没有图片数据');
            }
        } catch (error) {
            console.log('获取收藏夹失败:', error);
        }
        
        return [];
    }
    
    // 从wallhaven API获取随机图片
    async function fetchWallhavenImages() {
        try {
            // 首先尝试从收藏夹获取图片
            const collectionImages = await fetchCollectionImages();
            
            // 如果收藏夹有图片，使用收藏夹的图片
            if (collectionImages.length > 0) {
                console.log(`使用收藏夹中的 ${collectionImages.length} 张图片`);
                return collectionImages;
            }
            
            // 如果收藏夹没有图片，使用备用图片
            console.log('收藏夹无图片，使用备用图片');
            return config.fallbackImages;
            
        } catch (error) {
            console.log('API获取失败，使用备用图片:', error);
            return config.fallbackImages;
        }
    }
    
    // 从数组中随机选择一张图片
    function getRandomImage(images) {
        if (!images || images.length === 0) {
            return config.fallbackImages[0];
        }
        const randomIndex = Math.floor(Math.random() * images.length);
        return images[randomIndex];
    }
    
    // 设置背景图片
    async function setRandomBackground() {
        const coverBlock = document.querySelector('.td-cover-block');
        if (coverBlock) {
            try {
                // 尝试从API获取图片
                const images = await fetchWallhavenImages();
                const randomImage = getRandomImage(images);
                
                coverBlock.style.backgroundImage = `url('${randomImage}')`;
                console.log('设置随机背景图片:', randomImage);
            } catch (error) {
                console.log('设置背景图片失败，使用备用图片:', error);
                // 使用备用图片
                const fallbackImage = getRandomImage(config.fallbackImages);
                coverBlock.style.backgroundImage = `url('${fallbackImage}')`;
            }
        }
    }
    
    // 公开的配置接口
    window.RandomBackground = {
        // 更新配置
        updateConfig: function(newConfig) {
            Object.assign(config, newConfig);
        },
        // 设置收藏夹信息
        setCollection: function(username, collectionId) {
            config.username = username;
            config.collectionId = collectionId;
        },
        // 手动刷新背景
        refresh: function() {
            setRandomBackground();
        },
        // 获取当前配置
        getConfig: function() {
            return { ...config };
        },
        // 获取收藏夹图片
        getCollectionImages: function() {
            return fetchCollectionImages();
        }
    };
    
    // 页面加载完成后设置随机背景
    document.addEventListener('DOMContentLoaded', function() {
        setRandomBackground();
    });
    
    // 如果页面已经加载完成，立即设置
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', setRandomBackground);
    } else {
        setRandomBackground();
    }
})(); 