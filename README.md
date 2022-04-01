# Mobile Test - Users List App

## 主要结构
    mvvm 

### 主要第三方库

    json 解析 GSON
    网络请求 OkHttp 
    图片加载 glide
    
### 目录 结构  

    www.wiredcraft.testmobile
            ./activity  页面
            ./adapter 适配器
            ./api  网络请求
                ->/model 数据结构体
            ./base 封装基类 
            ./viewmodel  页面模具
            ......

### base 

    -为了使用 和 简化代码的封装

    1.  创建 adapter
        // ... 配置需要绑定的结构体 以及要绑定的 图层binding
        class ReposAdapter(list: ObservableArrayList<...Data>) :
            ObservableBindingRecyclerViewAdapter<...Data, ...Binding>(list) {
        
            override fun onCreateViewBinding(
                inflater: LayoutInflater,
                root: ViewGroup?,
                viewType: Int,
                attachToRoot: Boolean
            ): ...Binding {
                // binding 布局
                 return ItemReposBinding.inflate(inflater, root, attachToRoot)
            }
        
            override fun onBindViewHolderViewBinding(
                holder: BindingViewHolder<...Binding>,
                position: Int,
                viewBinding: ItemReposBinding,
                item: ReposData
            ) {
                super.onBindViewHolderViewBinding(holder, position, viewBinding, item)
                // 如果需要绑定model 可以在这里绑定
            }
        }

    2. 创建 acitivity
        
        //配置目标 图层binding  以及 图层 对应的viewModel
        class ...Activity : BaseActivity<...Binding, ...ViewModel>() {
            
            // 创建 viewModel
            override fun createViewModel(): UserDetailsViewModel {
                return ...ViewModel()
            }
        
            // 需要配置 页面资源
            override fun layoutId(): Int {
                return R.layout.activity_...
            }
            
            // 注册 绑定 或着初始化需要的东西
            override fun initialize(savedInstanceState: Bundle?) {
                binding.vm = viewModel
                ...
            }
        
        }
        

### 其他

    UI  我不知道是不是残缺的设计稿，没有返回按钮 ，但是为了保持与设计稿相同，还是不处理了。

    其他也没啥特别的了,为了方便使用了很多第三方库,欢迎给予审批和意见。