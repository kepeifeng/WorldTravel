//
//  LocationPickerViewController.m
//  2bulu-QuanZi
//
//  Created by Kent Peifeng Ke on 14-7-8.
//  Copyright (c) 2014年 Lolaage. All rights reserved.
//

#import "LocationPickerViewController.h"
#import "UIViewController+Progress.h"
#import "MapHelper.h"

typedef NS_ENUM(NSInteger, TABLE_SECTION){
    PICKER_LOCATION_SECTION = 0,
    MAP_CENTER_LOCATION_SECTION,
    SEARCH_RESULT_SECTION
    
};



@interface LocationPickerViewController ()<BMKMapViewDelegate, UISearchBarDelegate, BMKPoiSearchDelegate,
BMKGeoCodeSearchDelegate, UITableViewDataSource, UITableViewDelegate, BMKLocationServiceDelegate,UIAlertViewDelegate>

@property(nonatomic,assign) CLLocationCoordinate2D centerCoordinate;

@property (nonatomic) NSString * currentAddress;

@property (nonatomic) CLLocationCoordinate2D userLocation;

@property (nonatomic) BOOL searchMode;
@property (nonatomic) NSIndexPath * selectedIndex;

@property (nonatomic) BOOL isUserInteraction;
@end

@implementation LocationPickerViewController{
    BMKMapView * _mapView;
    UITableView * _tableView;
    BMKPoiSearch * _poiSearch;
    BMKGeoCodeSearch * _geoSearch;
    NSMutableArray * _addressArray;
    UISearchBar * _searchBar;
    UITableView * _searchTableView;
    UIView * _darkMaskView;
    BMKLocationService *_locationService;
    UIButton * _gotoMyLocationButton;
    UIActivityIndicatorView * _updatingUserLocationIndicator;
    BMKPointAnnotation * _selectedLocationAnnotation;
    UIView * _zoomControlsView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _addressArray = [[NSMutableArray alloc] init];
        self.doneButtonTitle = @"确定";
        self.isUserInteraction = YES;
        self.useGPSCoordinate = YES;
    }
    return self;
}
-(void)loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect viewFrame = self.view.bounds;
    
    //Search Bar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewFrame), 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索地点";
    [self.view addSubview:_searchBar];
    
    //Map View
    CGRect mapViewFrame = viewFrame;
    mapViewFrame.origin.y = CGRectGetHeight(_searchBar.frame);
    mapViewFrame.size.height = 200;
    
    _mapView = [[BMKMapView alloc] initWithFrame:mapViewFrame];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _mapView.zoomLevel = 15;
    _mapView.showsUserLocation = YES;
    
    [self.view addSubview:_mapView];
    
    //缩放控制
    _zoomControlsView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(mapViewFrame) - 10 - 90, 40, 90)];
    //放大按钮
    UIButton *zoomInButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [zoomInButton setImage:[UIImage imageNamed:@"icon-zoomin"] forState:UIControlStateNormal];
    zoomInButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [zoomInButton addTarget:self action:@selector(zoomInButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_zoomControlsView addSubview:zoomInButton];
    //缩小按钮
    UIButton *zoomOutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 40, 40)];
    [zoomOutButton setImage:[UIImage imageNamed:@"icon-zoomout"] forState:UIControlStateNormal];
    zoomOutButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [zoomOutButton addTarget:self action:@selector(zoomOutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_zoomControlsView addSubview:zoomOutButton];
    
    [self.view addSubview:_zoomControlsView];
    
    
    //显示用户位置按钮
    _gotoMyLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(mapViewFrame) - 50, CGRectGetMaxY(mapViewFrame)-50, 40, 40)];
    _gotoMyLocationButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [_gotoMyLocationButton setImage:[UIImage imageNamed:@"icon-user-location"] forState:UIControlStateNormal];
    [_gotoMyLocationButton addTarget:self action:@selector(gotoMyLocationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _gotoMyLocationButton.enabled = NO;
    _updatingUserLocationIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat halfButtonHeight = _gotoMyLocationButton.bounds.size.height / 2;
    CGFloat buttonWidth = _gotoMyLocationButton.bounds.size.width;
    _updatingUserLocationIndicator.center = CGPointMake(buttonWidth - halfButtonHeight , halfButtonHeight);
    
    [_gotoMyLocationButton addSubview:_updatingUserLocationIndicator];
    [self.view addSubview:_gotoMyLocationButton];
    [_updatingUserLocationIndicator startAnimating];
    
    
    //保持在地图中心的地点标志
    UIImageView *centerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 13)];
//    centerIcon.image = [UIImage imageNamed:@"map-location-mark"];
    centerIcon.image = [UIImage imageNamed:@"cross-location"];
    CGPoint centerPoint = _mapView.center;
//    centerPoint.y -= 20;
    centerIcon.center = centerPoint;
    [self.view addSubview:centerIcon];
    
    //Table View
    CGRect tableViewFrame = viewFrame;
    tableViewFrame.origin.y = CGRectGetMaxY(_mapView.frame);
    tableViewFrame.size.height = CGRectGetHeight(viewFrame) - CGRectGetMaxY(_mapView.frame);
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
    CGRect searchTableViewFrame = viewFrame;
    searchTableViewFrame.origin.y = CGRectGetHeight(_searchBar.frame);
    searchTableViewFrame.size.height -= CGRectGetHeight(_searchBar.frame);
    
    _darkMaskView = [[UIView alloc] initWithFrame:searchTableViewFrame];
    _darkMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _darkMaskView.hidden = YES;
    _darkMaskView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_darkMaskView];

    _searchTableView = [[UITableView alloc] initWithFrame:searchTableViewFrame];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.hidden = YES;
    _searchTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_searchTableView];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _poiSearch = [[BMKPoiSearch alloc] init];
    _geoSearch = [[BMKGeoCodeSearch alloc] init];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(gestureRecognized:)];
    [_darkMaskView addGestureRecognizer:tapGestureRecognizer];

    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:self.doneButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    
    if (self.location) {
        self.isUserInteraction = NO;
        self.centerCoordinate = (_useGPSCoordinate)? [MapHelper baiduCoordinateFromGpsCoordinate:self.location.coordinate]:self.location.coordinate;
        self.selectedIndex = [NSIndexPath indexPathForRow:0 inSection:PICKER_LOCATION_SECTION];
    }
    
    if (self.userLocation.latitude || self.userLocation.latitude) {
//        self.centerCoordinate = self.userLocation;
//        BMKUserLocation * userLocation = [[BMKUserLocation alloc] init];
        
    }else{
        _locationService = [[BMKLocationService alloc] init];
        _locationService.delegate = self;
        [_locationService startUserLocationService];
    }

    if (self.displayZoomControls) {
        _zoomControlsView.hidden = NO;
    }else{
        _zoomControlsView.hidden = YES;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    _poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geoSearch.delegate = self;
    _locationService.delegate = self;
    self.isUserInteraction = NO;
    self.centerCoordinate = _mapView.centerCoordinate;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
    _poiSearch.delegate = nil; // 不用时，置nil
    _geoSearch.delegate = nil;
    _locationService.delegate = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gestureRecognized:(UIGestureRecognizer *)gestureRecognizer{

    self.searchMode = NO;
    
}

#pragma mark - Property

-(void)setCurrentAddress:(NSString *)currentAddress{
    _currentAddress = currentAddress;
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:MAP_CENTER_LOCATION_SECTION]] withRowAnimation:(UITableViewRowAnimationNone)];
    if (self.selectedIndex.section == MAP_CENTER_LOCATION_SECTION && self.selectedIndex.row == 0) {
        //刷新
        self.selectedIndex = _selectedIndex;
    }
}

-(void)setSearchMode:(BOOL)searchMode{
    _searchMode = searchMode;
    if (searchMode) {
        _darkMaskView.hidden = NO;
        [_searchBar setShowsCancelButton:YES animated:YES];
    }else{
        _searchTableView.hidden = YES;
        _darkMaskView.hidden = YES;
        [_searchBar resignFirstResponder];
        [_searchBar setShowsCancelButton:NO animated:YES];
    }
}

-(void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate{
    _centerCoordinate = centerCoordinate;
    self.currentAddress = nil;
    //    发起反向地理编码检索
    CLLocationCoordinate2D pt = centerCoordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geoSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        self.currentAddress = @"正在解析...";
        //        [self startLoadingWithText:@"正在定位..."];
        NSLog(@"正在检索坐标所在地址");
    }
    else
    {
        //        [UIAlertView showAlert:@"提示" msg:@"未能定位你所在的城市,请手动选择"];
        NSLog(@"反geo检索发送失败");
    }
    
    if (self.isUserInteraction) {
//        NSLog(@"try to get nearby info");
        self.selectedIndex = [NSIndexPath indexPathForRow:0 inSection:MAP_CENTER_LOCATION_SECTION];
    }
    self.isUserInteraction = YES;
}


-(void)setSelectedIndex:(NSIndexPath *)selectedIndexPath{
    NSIndexPath * oldIndex = _selectedIndex;
    _selectedIndex = selectedIndexPath;
    CLLocationCoordinate2D coordinate;
    if (_mapView.annotations.count) {
        [_mapView removeAnnotations:_mapView.annotations];
    }
    
    if (oldIndex) {
        [_tableView reloadRowsAtIndexPaths:@[oldIndex] withRowAnimation:(UITableViewRowAnimationNone)];
    }
    
    if(selectedIndexPath){
        [_tableView reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    }
    
    if (!selectedIndexPath) {
        return;
    }
    
    BMKPointAnnotation * pointAnnotation = [[BMKPointAnnotation alloc] init];
    if (selectedIndexPath.section == PICKER_LOCATION_SECTION && selectedIndexPath.row == 0) {
        coordinate = (_useGPSCoordinate)? [MapHelper baiduCoordinateFromGpsCoordinate:self.location.coordinate]:self.location.coordinate;
        pointAnnotation.title = self.location.title;
        pointAnnotation.subtitle = self.location.subtitle;
        pointAnnotation.coordinate = coordinate;
        [_mapView setCenterCoordinate:coordinate animated:YES];
    }else if(selectedIndexPath.section == MAP_CENTER_LOCATION_SECTION && selectedIndexPath.row == 0){
        //Move to my location
        coordinate = self.centerCoordinate;
        pointAnnotation.title = @"当前位置";
        pointAnnotation.subtitle = self.currentAddress;
        pointAnnotation.coordinate = self.centerCoordinate;
    }else{
        BMKPoiInfo * poiInfo = [_addressArray objectAtIndex:selectedIndexPath.row];
        coordinate = poiInfo.pt;
        
        //        pointAnnotation.title = poiInfo.address;
        pointAnnotation.title = poiInfo.name;
        pointAnnotation.subtitle = poiInfo.address;
        pointAnnotation.coordinate = poiInfo.pt;
        //        _mapView.centerCoordinate = coordinate;
        [_mapView setCenterCoordinate:coordinate animated:YES];
        
    }
    [_mapView addAnnotation:pointAnnotation];
    
    [_mapView selectAnnotation:pointAnnotation animated:NO];
    //    self.selectedIndex = index;
    
    

}


#pragma mark - Methods

-(void)cancelButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)zoomInButtonTapped:(id)sender{
    [_mapView zoomIn];
}

-(void)zoomOutButtonTapped:(id)sender{
    [_mapView zoomOut];
}


-(void)gotoMyLocationButtonTapped:(id)sender{
//    _mapView.centerCoordinate = self.userLocation;
    [_mapView setCenterCoordinate:self.userLocation animated:YES];
}


-(void)didSelectedLocation{
    
    
    if ([self.delegate respondsToSelector:@selector(locationPicker:didPickedLocation:withTitle:subTitle:)]) {
        [self.delegate locationPicker:self
                    didPickedLocation:_selectedLocationAnnotation.coordinate
                            withTitle:_selectedLocationAnnotation.title
                             subTitle:_selectedLocationAnnotation.subtitle];
        
    }
}

-(void)doneButtonTapped:(id)sender{
    
//    UIImage * shot = [_mapView takeSnapshot];
    CLLocationCoordinate2D coordinate;
    NSString * title;
    NSString * subtitle;
    if (self.selectedIndex.section == PICKER_LOCATION_SECTION) {
        coordinate = self.location.coordinate;
        title = self.location.title;
        subtitle = self.location.subtitle;
    }else if (self.selectedIndex.section == MAP_CENTER_LOCATION_SECTION) {
        coordinate = self.centerCoordinate;
        if (self.useGPSCoordinate) {
            coordinate = [MapHelper baiduMapTransformWGSCoordinate:coordinate];
        }
        title = self.location.title;
        subtitle = self.currentAddress;
    }else if(self.selectedIndex.section == SEARCH_RESULT_SECTION){
        BMKPoiInfo * poiInfo = [_addressArray objectAtIndex:self.selectedIndex.row];
        coordinate = poiInfo.pt;
        if (self.useGPSCoordinate) {
            coordinate = [MapHelper baiduMapTransformWGSCoordinate:coordinate];
        }
        title = poiInfo.name;
        subtitle = poiInfo.address;
    }
    _selectedLocationAnnotation = [[BMKPointAnnotation alloc] init];
    _selectedLocationAnnotation.coordinate = coordinate;
    _selectedLocationAnnotation.title = title;
    _selectedLocationAnnotation.subtitle = subtitle;

    if (self.shouldEditTitle) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入位置名称"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * textField = [alertView textFieldAtIndex:0];
        textField.text = title;
        [alertView show];
        return;
    }else{
        [self didSelectedLocation];
    }
    
    
}
#pragma mark - Alert View Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    UITextField * textField = [alertView textFieldAtIndex:0];
    NSString * title = textField.text;
    if (title.length == 0) {
        [self showMessageWithTitle:@"提示" message:@"请输入位置名称" cancelButtonTitle:@"我知道了"];
        return;
    }
    
    _selectedLocationAnnotation.title = title;
    [self didSelectedLocation];
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == _searchTableView) {
        return 1;
    }
    NSInteger sectionCount = 3;
//    if (self.location) {
//        sectionCount++;
//    }
    return sectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger numberOfRow = _addressArray.count;
    if (tableView == _searchTableView) {
        return numberOfRow;
    }
    
    if (tableView == _tableView) {
        if (section == PICKER_LOCATION_SECTION) {
            return (self.location)?1:0;
        }
        else if(section == MAP_CENTER_LOCATION_SECTION){
            return 1;
        }
        else{
            return numberOfRow;
        }
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * AddressTableCell = @"AddressTableCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressTableCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddressTableCell];
    }
    
    if (tableView ==_tableView) {
        if (indexPath.section == PICKER_LOCATION_SECTION && indexPath.row ==0) {
            cell.textLabel.text = self.location.title;
            cell.detailTextLabel.text = self.location.subtitle;
        }else if (indexPath.section == MAP_CENTER_LOCATION_SECTION && indexPath.row == 0) {
            cell.textLabel.text = @"地图位置";
            cell.detailTextLabel.text = self.currentAddress;
        }else{
            BMKPoiInfo * poiInfo = [_addressArray objectAtIndex:indexPath.row];
            cell.textLabel.text = poiInfo.name;
            cell.detailTextLabel.text = poiInfo.address;
        }
        if (indexPath.section==self.selectedIndex.section && indexPath.row == self.selectedIndex.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else{
        BMKPoiInfo * poiInfo = [_addressArray objectAtIndex:indexPath.row];
        cell.textLabel.text = poiInfo.name;
        cell.detailTextLabel.text = poiInfo.address;
    }
    

    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isUserInteraction = NO;
    if (tableView == _searchTableView) {
        self.searchMode = NO;
        
        [_tableView reloadData];
//        [self selectItemAtIndex:indexPath.row+1];
        self.selectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:SEARCH_RESULT_SECTION];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:SEARCH_RESULT_SECTION]
                          atScrollPosition:(UITableViewScrollPositionMiddle)
                                  animated:NO];
    }else if (tableView == _tableView){
//        [self selectItemAtIndex:indexPath.row];
        self.selectedIndex = indexPath;
    }
}


#pragma mark - Search Bar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    self.searchMode = YES;
    return YES;
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    if (!searchBar.text.length) {
        return;
    }
    int curPage = 0;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    // BOOL flag = [_search poiSearchInCity:@"深圳" withKey:searchBar.text pageIndex:curPage];
    //        BOOL flag = [_search poiSearchNearBy:searchBar.text center:_searchCoord radius:3000000 pageIndex:curPage];
    BMKNearbySearchOption * searchOption = [[BMKNearbySearchOption alloc] init];
    searchOption.keyword = searchBar.text;
    searchOption.location = self.centerCoordinate;
    searchOption.radius = 3000000;
    searchOption.pageIndex = curPage;
    BOOL flag = [_poiSearch poiSearchNearBy:searchOption];
    if (flag) {
        //         [SVProgressHUD showWithStatus:@"正在搜索..."];
        [self startLoadingWithText:@"正在搜索..."];
        NSLog(@"searching...");
    }
    else{
        [self showMessage:@"搜索失败"];
        NSLog(@"search failed!");
    }
    
    
    _searchTableView.hidden = NO;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.searchMode = NO;
}



#pragma mark MKMapViewDelegate -user location定位变化

/*
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.userLocation = [userLocation coordinate];
    //放大地图到自身的经纬度位置。
    self.userRegion = MKCoordinateRegionMakeWithDistance(self.userLocation, 200, 200);
    
    if (self.mapType != RegionNavi) {
        if (self.updateInt >= 1) {
            return;
        }
        [self showAnnotation:userLocation.location coord:self.userLocation];
        [_mapView setRegion:self.userRegion animated:NO];
    }
}*/

-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

//    if ([mapView.annotations count]) {
//        [mapView removeAnnotations:mapView.annotations];
//    }
//
//    if (self.updateInt == 0){
//        return;
//    }
    self.centerCoordinate = mapView.centerCoordinate;
    
//    CLLocation *loc = [[CLLocation alloc] initWithLatitude:self.centerCoordinate.latitude longitude:self.centerCoordinate.longitude];
    
    

}


-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pointview"];
        if (!annotationView) {
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pointview"];
//            annotationView.image = [UIImage imageNamed:@"map-red-dot"];
//            annotationView.frame = CGRectMake(0, 0, 22, 22);

            annotationView.image = [UIImage imageNamed:@"map-location-mark"];
            annotationView.frame = CGRectMake(0, 0, 25, 40);
            annotationView.centerOffset = CGPointMake(0, -20);

        }
        annotationView.annotation = annotation;
        return annotationView;
    }
    return nil;
}
#pragma mark - Geo Code Search Delegate

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    [self stopLoading];
    if (error == BMK_SEARCH_NO_ERROR) {
        
//        BMKAddressComponent * address = result.addressDetail;
        self.currentAddress =result.address;
        NSLog(@"%@",self.currentAddress);
//        District * district = [[District alloc] initWithProvince:address.province
//                                                            city:address.city
//                                                          county:address.district];
//        [self locationChangedTo:district];
    }
    else {
//        [UIAlertView showAlert:@"提示" msg:@"未能定位你所在的城市,请手动选择"];
        [self showMessage:@"未能定位你所在的城市"];
        //      NSLog(@"抱歉，未找到结果");
    }
    
}


-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    [self stopLoading];
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        [_addressArray removeAllObjects];
		BMKPoiResult* result = poiResult;
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            
            [_addressArray addObject:poi];
//            [pointArr addObject:poi];
		}
	}
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        [self showMessage:@"关键词有歧义"];
    }
    else if (errorCode == BMK_SEARCH_RESULT_NOT_FOUND){
        [self showMessage:@"没有搜索结果"];
    }else{
        [self showMessage:@"搜索失败"];
    }

    
    [_searchTableView reloadData];
}


#pragma mark - User Location Service Delegate
-(void)willStartLocatingUser{
    NSLog(@"will start locating user");
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    self.userLocation = userLocation.location.coordinate;
    _gotoMyLocationButton.enabled = YES;
    _updatingUserLocationIndicator.hidden = YES;
    [_locationService stopUserLocationService];
    if (!self.location) {
        
        [self gotoMyLocationButtonTapped:nil];
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
//    [_locationService stopUserLocationService];
    NSLog(@"location error");
}



@end


@implementation LocationPickerValue

-(instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle{
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}

@end
