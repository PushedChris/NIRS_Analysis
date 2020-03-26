### 软件结构
##Summary of NIRS data analysis methods.
```c++
近红外数据分析
│  DeBaseline_Wavelet.m          //小波去基线程序
│  list.txt
│  lowpass5.m
│  nirs_main.m					//****所有功能的演示*****
│  plot_ICAs.m
│  README.md           				
│  小波对比试验.jpg
│  
├─characterization
│  │  ApEn.m					
│  │  nonlinearity.m			//非线性特征测试
│  │  SampEn.m					
│  │  statistical.m				//统计特征测试
│  │  subsection.m
│  │  
│  ├─approximateEntropyAlgorithm
│  │      ApEn.m
│  │      mainApEn.m
│  │      近似熵值的计算.doc
│  │      近似熵应用.doc
│  │      
│  └─MultiScaleEntropy
│          
├─FastICA_25						//ICA工具库
│          
├─raw
│      1.mat
│      1.TXT
│      convert.mat					//转换后的数据
│      get_onset_dur_txt.m
│      onset.txt
│      SPM_indiv_HbO.mat
│      SPM_indiv_HbR.mat
│      spm_shimadzu_convert_data.m
│      
├─time-frequency
│      cwt_realize.m				//小波分析
│      stft.m						//短时傅里叶变换	
│      TimeFreq_Analysis.m		
│      wavelet.m
│      welch.m						//功率谱分析
│      
├─小波去基线漂移实验
│      DeBaseLineExpe_wavelet.asv
│      DeBaseLineExpe_wavelet.m
│      DeBaseLineExpe_wavelet1.m
│      DeBaseLinePower.asv
│      DeBaseLinePower.m
│      multdecomposition.asv
│      multdecomposition.m
│      waveletfilter.m
│      分解效果.bmp
│      滤波效果.bmp
│      滤波效果1.bmp
│      
└─脑地形图程序
        bp1.txt
        topoplotEEG.m
        说明.txt
```

### 结果展示
![image][https://github.com/PushedChris/NIRS_Analysis/blob/master/summary.png]
