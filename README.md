## ExpressCoin - iOS ver.

<img src="https://img.shields.io/scrutinizer/build/g/filp/whoops.svg"/> <img src="https://img.shields.io/cocoapods/v/AFNetworking.svg"/> <img src="https://img.shields.io/badge/swift-4.0-orange.svg" />

---

####Folder Structure

- View
  - 기타 뷰들 : ex) HeaderViewForSection
- Cell
  - 재사용 가능한 셀들 : ex) TextFieldTextViewCell
- Resource
  - 거래소 이름, 코인 종류
  - 추후 다른 방법을 모색
- Model
  - 코인 데이터 : 구매시 가격, 구매량, 거래소, 수익률 ...
- Extensions
  - 프로젝트 내에서 필요한 Extension : UIColor.themeDark, NSObject.reusableIdentifier … 
- ViewControllers
  - MainVC : 매인 ViewController -> 그룹별로 섹션을 나누어 보유 중인 코인을 보여줌
  - EditCoinVC : 코인을 추가/수정 ViewController -> 거래소, 코인 종류 선택 및 구매 정보 입력
  - SelectExchangeVC : 거래소 선택 ViewController
  - SelectCoinVC : 코인 선택 ViewController

#### 해야할 것들

1. API Call
   1. API 서버 완성되면 
2. 데이터 영구 저장
3. 코인 프로퍼티 추가
4. UI 개선