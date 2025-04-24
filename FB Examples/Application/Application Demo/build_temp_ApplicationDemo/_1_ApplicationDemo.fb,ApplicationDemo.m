#import "_1_ApplicationDemo.fb,ApplicationDemo.h"
#import "ArrayIndices.h"

#import "_0_TranslatedRuntime.h"

///////////////////////////////////////////////////
//       translated globals and fns              //
///////////////////////////////////////////////////
 
void  BuildMenu( void ) 
{
  CUI_Menu( 0, 0, kFBParamMissing, CFSTR( "About Customer Info App" ), NULL, kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 0, 1, kFBParamMissing, NULL, NULL, kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 0, 2, kFBParamMissing, CFSTR( "Preferences…" ), CFSTR( "," ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, - 1, kFBParamMissing, CFSTR( "File" ), NULL, kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, 0, kFBParamMissing, CFSTR( "New" ), CFSTR( "n" ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, 1, kFBParamMissing, CFSTR( "Open…" ), CFSTR( "o" ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, 2, kFBParamMissing, CFSTR( "Save" ), CFSTR( "s" ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, 3, kFBParamMissing, NULL, NULL, kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 1, 4, kFBParamMissing, CFSTR( "Close" ), CFSTR( "w" ), kFBParamMissing, kFBParamMissing ); 
  MenuItemSetAction( 1, 4, CFSTR( "performClose:" ) ); 
  CUI_EditMenu( 2 ); 
  CUI_Menu( 3, - 1, kFBParamMissing, CFSTR( "Customers" ), NULL, kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 3, 0, kFBParamMissing, CFSTR( "Search Customer" ), CFSTR( "f" ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 3, 1, kFBParamMissing, CFSTR( "Add New Customer" ), CFSTR( "+" ), kFBParamMissing, kFBParamMissing ); 
  CUI_Menu( 3, 2, kFBParamMissing, CFSTR( "Delete Customer" ), CFSTR( "-" ), kFBParamMissing, kFBParamMissing ); 
}  
  
 
void  BuildWindow( void ) 
{
  CGRect            r = { {(double)0,(double)0},{(double)450,(double)300} }; 
  CUI_Window( 1, CFSTR( "Customer Information" ), r, NSWindowStyleMaskTitled + NSWindowStyleMaskClosable + NSWindowStyleMaskMiniaturizable ); 
  WindowSetFrameUsingName( 1, CFSTR( "CustomerInfoWindow" ) ); 
  CGFloat           y = (double)260; 
  CGFloat           labelWidth = (double)100; 
  CGFloat           fieldWidth = (double)280; 
  CGFloat           fieldHeight = (double)22; 
  CGFloat           verticalGap = (double)36; 
  r = CGRectMake( (double)20, y, labelWidth, fieldHeight ); 
  CUI_TextLabel( 1, CFSTR( "Name:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)130, y, fieldWidth, fieldHeight ); 
  CUI_TextField( 2, kFBParamMissing, NULL, r, kFBParamMissing ); 
  y -= verticalGap; 
  r = CGRectMake( (double)20, y, labelWidth, fieldHeight ); 
  CUI_TextLabel( 3, CFSTR( "Address:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)130, y, fieldWidth, fieldHeight ); 
  CUI_TextField( 4, kFBParamMissing, NULL, r, kFBParamMissing ); 
  y -= verticalGap; 
  r = CGRectMake( (double)20, y, labelWidth, fieldHeight ); 
  CUI_TextLabel( 5, CFSTR( "City:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)130, y, fieldWidth, fieldHeight ); 
  CUI_TextField( 6, kFBParamMissing, NULL, r, kFBParamMissing ); 
  y -= verticalGap; 
  r = CGRectMake( (double)20, y, labelWidth, fieldHeight ); 
  CUI_TextLabel( 7, CFSTR( "State:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)130, y, (double)60, fieldHeight ); 
  CUI_TextField( 8, kFBParamMissing, NULL, r, kFBParamMissing ); 
  r = CGRectMake( (double)230, y, (double)60, fieldHeight ); 
  CUI_TextLabel( 9, CFSTR( "Zip:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)290, y, (double)120, fieldHeight ); 
  CUI_TextField( 10, kFBParamMissing, NULL, r, kFBParamMissing ); 
  y -= verticalGap; 
  r = CGRectMake( (double)20, y, labelWidth, fieldHeight ); 
  CUI_TextLabel( 11, CFSTR( "Account #:" ), r, kFBParamMissing ); 
  r = CGRectMake( (double)130, y, fieldWidth, fieldHeight ); 
  CUI_TextField( 12, kFBParamMissing, NULL, r, kFBParamMissing ); 
  y -= (double)60; 
  r = CGRectMake( (double)130, y, (double)100, (double)30 ); 
  CUI_Button( 13, kFBParamMissing, kFBParamMissing, CFSTR( "Save" ), r, kFBParamMissing, kFBParamMissing, kFBParamMissing ); 
  r = CGRectMake( (double)250, y, (double)100, (double)30 ); 
  CUI_Button( 14, kFBParamMissing, kFBParamMissing, CFSTR( "Clear" ), r, kFBParamMissing, kFBParamMissing, kFBParamMissing ); 
}  
  
 
void  ClearFields( void ) 
{
  CUI_TextField( 2, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
  CUI_TextField( 4, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
  CUI_TextField( 6, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
  CUI_TextField( 8, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
  CUI_TextField( 10, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
  CUI_TextField( 12, kFBParamMissing, CFSTR( "" ), CGRectZero, kFBParamMissing ); 
}  
  
 
void  SaveCustomerInfo( void ) 
{
  CFStringRef       name = ControlStringValue( 2 ); 
  CFStringRef       account = ControlStringValue( 12 ); 
  CFStringRef       message = StringWithFormat( CFSTR( "Customer information for %@ (Account: %@) has been saved." ), name, account ); 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "Information Saved" ), message, NULL, kFBParamMissing ); 
}  
  
 
void  DoDialog( long ev, long tag, long wnd ) 
{
 
  gSelectL[1] = (ev); 
  if ( gSelectL[1] == 1 ) 
  { 
 
  gSelectL[2] = (tag); 
  if ( gSelectL[2] == 13 ) 
  { 
  SaveCustomerInfo(); 
  } 
  else  if ( gSelectL[2] == 14 ) 
  { 
  ClearFields(); 
  } 
 
  } 
  else  if ( gSelectL[1] == windowWillClose ) 
  { 
  } 
 
}  
  
 
void  DoMenu( long menuID, long itemID ) 
{
 
  gSelectL[1] = (menuID); 
  if ( gSelectL[1] == 0 ) 
  { 
 
  gSelectL[2] = (itemID); 
  if ( gSelectL[2] == 0 ) 
  { 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "About Customer Info App" ), CFSTR( "Customer Information App v1.0\nCreated with FutureBasic 7" ), NULL, kFBParamMissing ); 
  } 
  else  if ( gSelectL[2] == 2 ) 
  { 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "Preferences" ), CFSTR( "Preferences are not implemented in this demo." ), NULL, kFBParamMissing ); 
  } 
 
  } 
  else  if ( gSelectL[1] == 1 ) 
  { 
 
  gSelectL[2] = (itemID); 
  if ( gSelectL[2] == 0 ) 
  { 
  ClearFields(); 
  } 
  else  if ( gSelectL[2] == 1 ) 
  { 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "Open Customer" ), CFSTR( "Open functionality is not implemented in this demo." ), NULL, kFBParamMissing ); 
  } 
  else  if ( gSelectL[2] == 2 ) 
  { 
  SaveCustomerInfo(); 
  } 
  else  if ( gSelectL[2] == 4 ) 
  { 
  } 
 
  } 
  else  if ( gSelectL[1] == 3 ) 
  { 
 
  gSelectL[2] = (itemID); 
  if ( gSelectL[2] == 0 ) 
  { 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "Search" ), CFSTR( "Search functionality is not implemented in this demo." ), NULL, kFBParamMissing ); 
  } 
  else  if ( gSelectL[2] == 1 ) 
  { 
  ClearFields(); 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "New Customer" ), CFSTR( "Enter information for the new customer." ), NULL, kFBParamMissing ); 
  } 
  else  if ( gSelectL[2] == 2 ) 
  { 
  CUI_Alert( 1, kFBParamMissing, CFSTR( "Delete Customer" ), CFSTR( "Delete functionality is not implemented in this demo." ), NULL, kFBParamMissing ); 
  } 
 
  } 
 
}  
  
 
void  DoAppEvent( long ev ) 
{
 
  gSelectL[1] = (ev); 
  if ( gSelectL[1] == appWillFinishLaunching ) 
  { 
  nsLog( CFSTR( "_appWillFinishLaunching" ) ); 
  BuildMenu(); 
  BuildWindow(); 
  } 
  else  if ( gSelectL[1] == appShouldTerminateAfterLastWindowClosed ) 
  { 
  AppEventSetBool( YES ); 
  } 
 
}  
  

///////////////////////////////////////////////////
//            translated main code               //
///////////////////////////////////////////////////
int main( int __unused argc, const char * __unused argv[] ) 
{ 
  CocoaInit(); 
  InitFBGlobals(); 
  BuildMenu(); 
  BuildWindow(); 
  CUI_SetOnAppEventFunction( (void *)DoAppEvent ); 
  CUI_SetOnMenuFunction( (void *)DoMenu ); 
  CUI_SetOnDialogFunction( (void *)DoDialog ); 
  FBHandleEvents(); 
  return 0; 
} 
  

