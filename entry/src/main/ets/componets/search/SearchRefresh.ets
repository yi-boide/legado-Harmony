import { ThemeStorageKey } from "../../common/constants/Theme";
import { ThemeItem } from "../../common/model/Theme";

@Component
export struct SearchRefresh{
  @State color:string="rgba(0, 0, 0, 0.45)"
  @Consume  SearchStatus: number;

  // 主题颜色
  @StorageProp(ThemeStorageKey.THEME) theme: ThemeItem = {} as ThemeItem

  @Builder refresh(){
    Stack(){
      Row(){
        LoadingProgress().color(this.theme.mainColor).height(30)
        Text("玩命加载中...").fontSize(16).margin({left:20}).fontColor(this.color)
      }.alignItems(VerticalAlign.Center)
    }.width("100%").height("100%").align(Alignment.Center)
  }
  build() {
    Column(){
      Refresh({refreshing:true,builder:this.refresh()}){

      }.height("10%")
        .onStateChange((refreshStatus: RefreshStatus) => {
          console.info('Refresh onStatueChange state is ' + refreshStatus)
        })
        .onRefreshing(() => {
          setTimeout(() => {
            this.SearchStatus = 2
          }, 3000)
          console.log('onRefreshing test')
        })
    }.height("80%").width("100%").justifyContent(FlexAlign.Center)
  }

}