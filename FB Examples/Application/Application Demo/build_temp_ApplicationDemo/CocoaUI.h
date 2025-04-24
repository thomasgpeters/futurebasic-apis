/*
  ____                         __   __  __
 /  __| ___   ___   ___   ___ |  | |  ||  |
|  /   / _ \ / __| / _ \ / _ \|  | |  ||  |
|  \__| (_) | (__ | (_) | (_) |  \_/  ||  |
 \____|\___/ \___| \___/|_| |_|\_____/ |__|
 
 CocoaUI.h
 
 Bernie Wylde 20170712 
 */

#import <Quartz/Quartz.h>
#import <CoreData/CoreData.h>
#import <objc/runtime.h>
#import "FBtoC.h"
#import "Runtime.h"

#pragma mark - Dev flags


#pragma mark -

// standard colors
enum {
    zCurrentColor = -1,// 20211210
    zNoColor = 0,
    //zWhite = 0,// changed to 8 20211229
    zYellow,
    zGreen,
    zCyan,
    zBlue,
    zMagenta,
    zRed,
    zBlack,
    zWhite,// = 8
    zBrown,
    zGray,
    zDarkGray,
    zLightGray,
    zOrange,
    zPurple,
    zClear,
    zText,
    zSystemBlue,
    zSystemBrown,
    zSystemCyan,
    zSystemGray,
    zSystemGreen,
    zSystemIndigo,
    zSystemMint,
    zSystemOrange,
    zSystemPink,
    zSystemTeal,
    zSystemYellow
};

// subclass flag
BOOL CUI_IsSubclassFlag( void );
void CUI_SetSubclassFlag( BOOL flag );

#pragma mark - suppress CocoaUI alerts
BOOL CUI_SuppressAlerts( void );
void CUI_SetSuppressAlerts( BOOL flag );

// superview
BOOL CUI_IsSuperview( void );
void CUI_SetSuperviewFlag( BOOL flag );
void CUI_AddSuperview( id superview );
id CUI_CurrentSuperview( void );
id CUI_PenultimateSuperview( void );
void CUI_RemoveSuperview( void );
void CUI_SuperviewEndStatement( void );

@class OutlineItem;
@class TableRowView;

#pragma mark - refs
typedef Class ClassRef;
typedef SEL SELRef;
typedef Ivar IvarRef;
typedef IMP IMPRef;
typedef Method MethodRef;

typedef Protocol *ProtocolRef;

typedef NSActionCell *ActionCellRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
typedef NSAdaptiveImageGlyph *AdaptiveImageGlyphRef;
#endif // 150000
typedef NSAffineTransform *AffineTransformRef;
typedef NSAlert *AlertRef;
typedef id<NSAnimatablePropertyContainer> AnimatablePropertyContainerRef;
typedef NSAnimationContext *AnimationContextRef;
typedef NSAnimation *AnimationRef;
typedef NSAppearance *AppearanceRef;
typedef NSAppleEventDescriptor *AppleEventDescriptorRef;
typedef NSAppleEventManager *AppleEventManagerRef;
typedef NSAppleScript *AppleScriptRef;
typedef NSApplication *ApplicationRef;
typedef NSAttributeDescription *AttributeDescriptionRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef NSAttributedStringMarkdownParsingOptions *AttributedStringMarkdownParsingOptionsRef;
#endif// 120000

#if !__has_feature(objc_arc)
typedef NSAutoreleasePool *AutoreleasePoolRef;
#endif

typedef NSBackgroundActivityScheduler *BackgroundActivitySchedulerRef;
typedef NSBezierPath *BezierPathRef;
typedef NSBitmapImageRep *BitmapImageRepRef;
typedef NSBlockOperation *BlockOperationRef;
typedef NSBox *BoxRef;
typedef NSBrowser *BrowserRef;
typedef NSBrowserCell *BrowserCellRef;
typedef NSBundle *BundleRef;
typedef NSButton *ButtonRef;
typedef NSButtonCell *ButtonCellRef;
typedef NSByteCountFormatter *ByteCountFormatterRef;

typedef id<CAAction> CAActionRef;
typedef CAAnimation *CAAnimationRef;
typedef CAAnimationGroup *CAAnimationGroupRef;
typedef CABasicAnimation *CABasicAnimationRef;

typedef NSCachedURLResponse *CachedURLResponseRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef CADisplayLink *CADisplayLinkRef;
#endif// 140000
typedef CAEmitterCell *CAEmitterCellRef;
typedef CAEmitterLayer *CAEmitterLayerRef;
typedef CAKeyframeAnimation *CAKeyframeAnimationRef;
typedef CAGradientLayer *CAGradientLayerRef;
typedef CALayer *CALayerRef;
typedef id<CAMediaTiming> CAMediaTimingRef;
typedef CAMediaTimingFunction *CAMediaTimingFunctionRef;
typedef CAPropertyAnimation *CAPropertyAnimationRef;
typedef CAReplicatorLayer *CAReplicatorLayerRef;
typedef CAScrollLayer *CAScrollLayerRef;
typedef CAShapeLayer *CAShapeLayerRef;

typedef CASpringAnimation *CASpringAnimationRef;

typedef CATextLayer *CATextLayerRef;
typedef CATiledLayer *CATiledLayerRef;
typedef CATransformLayer *CATransformLayerRef;
typedef CATransition *CATransitionRef;
typedef CAValueFunction *CAValueFunctionRef;
typedef NSCell *CellRef;

typedef NSClickGestureRecognizer *ClickGestureRecognizerRef;

typedef NSClipView *ClipViewRef;
typedef NSCoder *CoderRef;
typedef NSColor *ColorRef;
typedef NSCollectionView *CollectionViewRef;
typedef NSCollectionViewItem *CollectionViewItemRef;

typedef NSCollectionViewLayout *CollectionViewLayoutRef;
typedef NSCollectionViewLayoutAttributes *CollectionViewLayoutAttributesRef;
typedef NSCollectionViewFlowLayout *CollectionViewFlowLayoutRef;
typedef NSCollectionViewGridLayout *CollectionViewGridLayoutRef;
typedef NSCollectionViewTransitionLayout *CollectionViewTransitionLayoutRef;
typedef NSCollectionViewFlowLayoutInvalidationContext *CollectionViewFlowLayoutInvalidationContextRef;
typedef NSCollectionViewLayoutInvalidationContext *CollectionViewLayoutInvalidationContextRef;

typedef NSColorList *ColorListRef;
typedef NSColorPanel *ColorPanelRef;
typedef NSColorSpace *ColorSpaceRef;
typedef NSColorWell *ColorWellRef;
typedef NSComboBox *ComboBoxRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
typedef NSComboButton *ComboButtonRef;
#endif// 130000
typedef NSComparisonPredicate *ComparisonPredicateRef;
typedef NSCompoundPredicate *CompoundPredicateRef;
typedef NSCondition *ConditionRef;
typedef NSConditionLock *ConditionLockRef;
typedef NSControl *ControlRef;
//typedef NSControl *CocoaControlRef;
typedef NSCountedSet *CountedSetRef;
typedef NSCursor *CursorRef;

typedef NSDataDetector *DataDetectorRef;
typedef NSDateComponents *DateComponentsRef;
typedef NSDateComponentsFormatter *DateComponentsFormatterRef;
typedef NSDateFormatter *DateFormatterRef;
typedef NSDateInterval *DateIntervalRef;
typedef NSDateIntervalFormatter *DateIntervalFormatterRef;
typedef NSDatePicker *DatePickerRef;
typedef NSDecimalNumber *DecimalNumberRef;
typedef id<NSDecimalNumberBehaviors> DecimalNumberBehaviorsRef;
typedef NSDecimalNumberHandler *DecimalNumberHandlerRef;

typedef NSDimension *DimensionRef;

typedef NSDirectoryEnumerator *DirectoryEnumeratorRef;
typedef NSDistributedLock *DistributedLockRef;
typedef NSDistributedNotificationCenter *DistributedNotificationCenterRef;
typedef NSDockTile *DockTileRef;
//typedef NSDocument *DocumentRef;
//typedef NSDocumentController *DocumentControllerRef;
typedef id<NSDraggingInfo> DraggingInfoRef;
typedef NSDraggingItem *DraggingItemRef;
typedef NSDraggingSession *DraggingSessionRef;
typedef id<NSDraggingSource> DraggingSourceRef;

typedef NSEnumerator *EnumeratorRef;
typedef NSError *ErrorRef;
typedef NSEvent *EventRef;
//typedef NSEvent *CocoaEventRef;
typedef NSException *ExceptionRef;
typedef NSExpression *ExpressionRef;
typedef NSExtensionContext *ExtensionContextRef;
typedef id<NSExtensionRequestHandling> ExtensionRequestHandlingRef;

typedef id<NSFastEnumeration> FastEnumerationRef;
typedef NSFileHandle *FileHandleRef;
typedef NSFileManager *FileManagerRef;
typedef NSFileWrapper *FileWrapperRef;
typedef NSFont *FontRef;
typedef CFTypeRef CTNSFontRef;
typedef NSFontDescriptor *FontDescriptorRef;
typedef NSFontManager *FontManagerRef;
typedef NSFontPanel *FontPanelRef;
typedef NSFormatter *FormatterRef;

typedef NSGestureRecognizer *GestureRecognizerRef;
typedef NSGlyphGenerator *GlyphGeneratorRef;
typedef id<NSGlyphStorage> GlyphStorageRef;
typedef NSGradient *GradientRef;
typedef NSGraphicsContext *GraphicsContextRef;

typedef NSGridCell *GridCellRef;
typedef NSGridColumn *GridColumnRef;
typedef NSGridRow *GridRowRef;
typedef NSGridView *GridViewRef;

typedef NSHashTable *HashTableRef;
typedef NSHelpManager *HelpManagerRef;
typedef NSHTTPCookieStorage *HTTPCookieStorageRef;
typedef NSHTTPURLResponse *HTTPURLResponseRef;

typedef NSImage *ImageRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
typedef NSImageSymbolConfiguration *ImageSymbolConfigurationRef;
#endif// 110000
typedef NSImageRep *ImageRepRef;
typedef NSImageView *ImageViewRef;
typedef NSIndexPath *IndexPathRef;
typedef NSIndexSet *IndexSetRef;
typedef NSMutableIndexSet *MutableIndexSetRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef NSInflectionRule *InflectionRuleRef;
API_AVAILABLE(macos(12.0))
typedef NSInflectionRuleExplicit *InflectionRuleExplicitRef;
API_AVAILABLE(macos(12.0))
typedef NSMorphology *MorphologyRef;
API_AVAILABLE(macos(12.0))
typedef NSMorphologyCustomPronoun *MorphologyCustomPronounRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef NSMorphologyPronoun *MorphologyPronounRef;
#endif// 140000
#endif// 120000

typedef NSStream *StreamRef;

typedef NSInputStream *InputStreamRef;

typedef NSInvocation *InvocationRef;
typedef NSInvocationOperation *InvocationOperationRef;

typedef NSISO8601DateFormatter *ISO8601DateFormatterRef;

typedef NSItemProvider *ItemProviderRef;

typedef id<NSItemProviderReading> ItemProviderReadingRef;
typedef id<NSItemProviderWriting> ItemProviderWritingRef;

typedef NSJSONSerialization *JSONSerializationRef;

typedef NSKeyedArchiver *KeyedArchiverRef;
typedef NSKeyedUnarchiver *KeyedUnarchiverRef;

typedef NSLayoutAnchor *LayoutAnchorRef;
typedef NSLayoutDimension *LayoutDimensionRef;
typedef NSLayoutGuide *LayoutGuideRef;
typedef NSLayoutXAxisAnchor *LayoutXAxisAnchorRef;
typedef NSLayoutYAxisAnchor *LayoutYAxisAnchorRef;

typedef NSLayoutConstraint *LayoutConstraintRef;
typedef NSLayoutManager *LayoutManagerRef;
typedef NSLevelIndicator *LevelIndicatorRef;
typedef NSLinguisticTagger *LinguisticTaggerRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSListFormatter *ListFormatterRef;
#endif// 101500
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
typedef NSLocalizedNumberFormatRule *LocalizedNumberFormatRuleRef;
#endif// 150000

typedef NSLock *LockRef;
typedef id<NSLocking> LockingRef;

typedef NSLogicalTest *LogicalTestRef;

typedef NSMagnificationGestureRecognizer *MagnificationGestureRecognizerRef;

typedef NSMapTable *MapTableRef;

typedef NSMeasurement *MeasurementRef;
typedef NSMeasurementFormatter *MeasurementFormatterRef;

typedef NSMediaLibraryBrowserController *MediaLibraryBrowserControllerRef;

typedef NSMenu *MenuRef;
//typedef NSMenu *CocoaMenuRef;
typedef NSMenuItem *MenuItemRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef NSMenuItemBadge *MenuItemBadgeRef;
#endif// 140000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSMenuToolbarItem *MenuToolbarItemRef;
#endif// 101500

typedef NSMethodSignature *MethodSignatureRef;

typedef NSNetService *NetServiceRef;
typedef NSNib *NibRef;
typedef NSNotification *NotificationRef;
typedef NSNotificationCenter *NotificationCenterRef;
typedef NSNotificationQueue *NotificationQueueRef;
typedef NSNumberFormatter *NumberFormatterRef;

typedef NSObject *ObjectRef;
//typedef NSObject *NSObjectRef;

typedef NSOpenPanel *OpenPanelRef;
typedef NSOperation *OperationRef;
typedef NSOperationQueue *OperationQueueRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSOrderedCollectionChange *OrderedCollectionChangeRef;
API_AVAILABLE(macos(10.15))
typedef NSOrderedCollectionDifference *OrderedCollectionDifferenceRef;
#endif// 101500

typedef NSOrderedSet *OrderedSetRef;
typedef NSMutableOrderedSet *MutableOrderedSetRef;
typedef NSOutlineView *OutlineViewRef;
typedef OutlineItem *OutlineItemRef;
typedef NSOrthography *OrthographyRef;
typedef NSOutputStream *OutputStreamRef;

typedef NSPageLayout *PageLayoutRef;
typedef NSPanGestureRecognizer *PanGestureRecognizerRef;
typedef NSPanel *PanelRef;
typedef NSParagraphStyle *ParagraphStyleRef;

typedef NSMutableParagraphStyle *MutableParagraphStyleRef;

//typedef NSPasteboard *PasteboardRef;
typedef NSPasteboard *Pasteboardref;// lowercase 'r' to avoid clash with PasteboardRef
typedef NSPasteboard *CocoaPasteboardRef;
typedef id<NSPasteboardWriting> PasteboardWritingRef;
typedef NSPathCell *PathCellRef;
typedef NSPathComponentCell *PathComponentCellRef;
typedef NSPathControlItem *PathControlItemRef;
typedef NSPathControl *PathControlRef;
typedef NSPDFInfo *PDFInfoRef;
typedef NSPDFPanel *PDFPanelRef;

typedef NSPersonNameComponents *PersonNameComponentsRef;
typedef NSPersonNameComponentsFormatter *PersonNameComponentsFormatterRef;

typedef NSPipe *PipeRef;
typedef NSPointerFunctions *PointerFunctionsRef;
typedef NSPointerArray *PointerArrayRef;
typedef NSPopover *PopoverRef;
typedef NSPopUpButton *PopUpButtonRef;
typedef NSPort *PortRef;
typedef NSPredicate *PredicateRef;
typedef NSPredicateEditor *PredicateEditorRef;
typedef NSPredicateEditorRowTemplate *PredicateEditorRowTemplateRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef NSPresentationIntent *PresentationIntentRef;
#endif // 120000
typedef NSPressGestureRecognizer *PressGestureRecognizerRef;
typedef NSPressureConfiguration *PressureConfigurationRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
typedef NSPreviewRepresentingActivityItem *PreviewRepresentingActivityItemRef;
typedef id<NSPreviewRepresentableActivityItem> PreviewRepresentableActivityItemRef;
#endif // 130000
typedef NSPrinter *PrinterRef;
typedef NSPrintInfo *PrintInfoRef;
typedef NSPrintOperation *PrintOperationRef;
typedef NSPrintPanel *PrintPanelRef;
typedef NSProcessInfo *ProcessInfoRef;
typedef NSProgress *ProgressRef;
typedef NSProgressIndicator *ProgressIndicatorRef;
typedef NSProgressIndicator *ProgressBarRef;
typedef NSPropertyDescription *PropertyDescriptionRef;

typedef NSRecursiveLock *RecursiveLockRef;

typedef NSRegularExpression *RegularExpressionRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSRelativeDateTimeFormatter *RelativeDateTimeFormatterRef;
#endif// 101500

typedef NSResponder *ResponderRef;
typedef NSRotationGestureRecognizer *RotationGestureRecognizerRef;
typedef NSRuleEditor *RuleEditorRef;
typedef NSRulerMarker *RulerMarkerRef;
typedef NSRulerView *RulerViewRef;
typedef NSRunLoop *RunLoopRef;
typedef NSRunningApplication *RunningApplicationRef;

typedef NSSavePanel *SavePanelRef;
typedef NSScanner *ScannerRef;
typedef NSScreen *ScreenRef;
typedef NSScriptObjectSpecifier *ScriptObjectSpecifierRef;
typedef NSScriptWhoseTest *ScriptWhoseTestRef;
typedef NSScroller *ScrollerRef;
typedef NSScrollView *ScrollViewRef;
typedef NSSearchField *SearchFieldRef;
typedef NSSearchFieldCell *SearchFieldCellRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
typedef NSSearchToolbarItem *SearchToolbarItemRef;
#endif// 110000
typedef id<NSSecureCoding> SecureCodingRef;
typedef NSSecureTextField *SecureTextFieldRef;
typedef NSSegmentedControl *SegmentedControlRef;
typedef NSShadow *ShadowRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
typedef NSSharingCollaborationModeRestriction *SharingCollaborationModeRestrictionRef;
#endif // 150000
typedef NSSharingService *SharingServiceRef;
typedef NSSharingServicePicker *SharingServicePickerRef;
typedef NSSlider *SliderRef;
typedef NSSortDescriptor *SortDescriptorRef;
typedef NSSound *SoundRef;
typedef NSSpecifierTest *SpecifierTestRef;
typedef NSSpeechRecognizer *SpeechRecognizerRef;
typedef NSSpeechSynthesizer *SpeechSynthesizerRef;
typedef NSSpellChecker *SpellCheckerRef;
typedef NSSplitView *SplitViewRef;
typedef NSSplitViewController *SplitViewControllerRef;
typedef NSSplitViewItem *SplitViewItemRef;
typedef NSStackView *StackViewRef;
typedef NSStatusBar *StatusBarRef;
typedef NSStatusBarButton *StatusBarButtonRef;
typedef NSStatusItem *StatusItemRef;
typedef NSStepper *StepperRef;

typedef NSStoryboard *StoryboardRef;
typedef NSStoryboardSegue *StoryboardSegueRef;

//typedef CFTypeRef CFNSStringRef;
typedef NSStringDrawingContext *StringDrawingContextRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSSwitch *SwitchRef;
#endif// 101500

typedef NSTableCellView *TableCellViewRef;
typedef NSTableColumn *TableColumnRef;
typedef NSTableHeaderCell *TableHeaderCellRef;
typedef NSTableHeaderView *TableHeaderViewRef;
typedef NSTableRowView *TableRowViewRef;
typedef NSTableView *TableViewRef;
typedef NSTabView *TabViewRef;
typedef NSTabViewItem *TabViewItemRef;
typedef NSTask *TaskRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef NSTermOfAddress *TermOfAddressRef;
#endif// 140000
typedef NSText *TextRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
typedef NSTextInsertionIndicator *TextInsertionIndicatorRef;
#endif// 140000
typedef NSTextAlternatives *TextAlternativesRef;
typedef NSTextAttachment *TextAttachmentRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef id<NSTextAttachmentLayout> TextAttachmentLayoutRef;
API_AVAILABLE(macos(12.0))
typedef NSTextAttachmentViewProvider *TextAttachmentViewProviderRef;
#endif// 120000
typedef id<NSTextAttachmentCell> TextAttachmentCellRef;
typedef id<NSTextAttachmentContainer> TextAttachmentContainerRef; // protocol
typedef NSTextBlock *TextBlockRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef id<NSTextCheckingClient> TextCheckingClientRef;
API_AVAILABLE(macos(10.15))
typedef id<NSTextInputTraits> TextInputTraitsRef;
API_AVAILABLE(macos(10.15))
typedef NSTextCheckingController *TextCheckingControllerRef;
#endif// 101500
typedef NSTextCheckingResult *TextCheckingResultRef;
typedef NSTextContainer *TextContainerRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
typedef id<NSTextContent> TextContentRef;
#endif// 110000
typedef NSTextField *TextFieldRef;
typedef NSTextField *TextLabelRef;
typedef NSTextFieldCell *TextFieldCellRef;
typedef NSTextList *TextListRef;
typedef id<NSTextFinderBarContainer> TextFinderBarContainerRef;
typedef id<NSTextFinderClient> TextFinderClientRef;
typedef NSTextFinder *TextFinderRef;
typedef id<NSTextInputClient> TextInputClientRef;
typedef NSTextStorage *TextStorageRef;
typedef NSTextTab *TextTabRef;
typedef NSTextTable *TextTableRef;
typedef NSTextTableBlock *TextTableBlockRef;
typedef NSTextView *TextViewRef;
typedef NSThread *ThreadRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
typedef NSTintConfiguration *TintConfigurationRef;
#endif// 110000
typedef NSTokenField *TokenFieldRef;
typedef NSToolbar *ToolbarRef;
typedef NSToolbarItem *ToolbarItemRef;
typedef NSToolbarItemGroup *ToolbarItemGroupRef;
typedef NSTouch *TouchRef;
typedef NSTrackingArea *TrackingAreaRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
typedef NSTrackingSeparatorToolbarItem *TrackingSeparatorToolbarItemRef;
#endif// 110000
typedef NSTypesetter *TypesetterRef;

typedef NSUbiquitousKeyValueStore *UbiquitousKeyValueStoreRef;
typedef NSUndoManager *UndoManagerRef;

typedef NSUnit *UnitRef;
typedef NSUnitConverter *UnitConverterRef;
typedef NSUnitConverterLinear *UnitConverterLinearRef;
typedef NSUnitAcceleration *UnitAccelerationRef;
typedef NSUnitAngle *UnitAngleRef;
typedef NSUnitArea *UnitAreaRef;
typedef NSUnitConcentrationMass *UnitConcentrationMassRef;
typedef NSUnitDispersion *UnitDispersionRef;
typedef NSUnitDuration *UnitDurationRef;
typedef NSUnitElectricCharge *UnitElectricChargeRef;
typedef NSUnitElectricCurrent *UnitElectricCurrentRef;
typedef NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceRef;
typedef NSUnitElectricResistance *UnitElectricResistanceRef;
typedef NSUnitEnergy *UnitEnergyRef;
typedef NSUnitFrequency *UnitFrequencyRef;
typedef NSUnitFuelEfficiency *UnitFuelEfficiencyRef;
typedef NSUnitLength *UnitLengthRef;
typedef NSUnitIlluminance *UnitIlluminanceRef;
typedef NSUnitMass *UnitMassRef;
typedef NSUnitPower *UnitPowerRef;
typedef NSUnitPressure *UnitPressureRef;
typedef NSUnitSpeed *UnitSpeedRef;
typedef NSUnitTemperature *UnitTemperatureRef;
typedef NSUnitVolume *UnitVolumeRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSUnitInformationStorage *UnitInformationStorageRef;
#endif// 101500
typedef NSURLCache *URLCacheRef;
typedef NSURLComponents *URLComponentsRef;
typedef NSURLCredentialStorage *URLCredentialStorageRef;
typedef NSURLQueryItem *URLQueryItemRef;
typedef NSURLRequest *URLRequestRef;
typedef NSMutableURLRequest *MutableURLRequestRef;
typedef NSURLResponse *URLResponseRef;
typedef NSURLSession *URLSessionRef;
typedef NSURLSessionConfiguration *URLSessionConfigurationRef;
typedef NSURLSessionTask *URLSessionTaskRef;
typedef NSURLSessionDataTask *URLSessionDataTaskRef;
typedef NSURLSessionDownloadTask *URLSessionDownloadTaskRef;
typedef NSURLSessionStreamTask *URLSessionStreamTaskRef;
typedef NSURLSessionUploadTask *URLSessionUploadTaskRef;
typedef NSUserActivity *UserActivityRef;
//typedef id<NSUserActivityRestoring> UserActivityRestoringRef;
typedef NSUserDefaults *UserDefaultsRef;
typedef NSUserDefaultsController *UserDefaultsControllerRef;

typedef id<NSUserInterfaceItemIdentification> UserInterfaceItemIdentificationRef;

typedef NSUserNotification *UserNotificationRef;
typedef NSUserNotificationAction *UserNotificationActionRef;
typedef NSUserNotificationCenter *UserNotificationCenterRef;
typedef NSUserScriptTask *UserScriptTaskRef;
typedef NSUserUnixTask *UserUnixTaskRef;
typedef NSUserAppleScriptTask *UserAppleScriptTaskRef;
typedef NSUserAutomatorTask *UserAutomatorTaskRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
typedef UTType *UTTypeRef;
#endif// 110000
typedef NSUUID *UUIDref;

typedef id<NSValidatedUserInterfaceItem> ValidatedUserInterfaceItemRef;
typedef NSValue *ValueRef;
typedef NSViewController *ViewControllerRef;
typedef NSView *ViewRef;
typedef NSViewAnimation *ViewAnimationRef;

typedef NSVisualEffectView *VisualEffectViewRef;

//typedef NSWindow *WindowRef;
typedef NSWindow *Windowref;
typedef NSWindow *CocoaWindowRef;
typedef NSWindowController *WindowControllerRef;

typedef NSWindowTab *WindowTabRef;
typedef NSWindowTabGroup *WindowTabGroupRef;

typedef NSWorkspace *WorkspaceRef;

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
typedef NSWorkspaceOpenConfiguration *WorkspaceOpenConfigurationRef;
#endif// 101500

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
typedef NSWorkspaceAuthorization *WorkspaceAuthorizationRef;
#endif// 101400

typedef id<QLPreviewingController> QLPreviewingControllerRef;
typedef id<QLPreviewItem> QLPreviewItemRef;
typedef QLPreviewPanel *QLPreviewPanelRef;
typedef id<QLPreviewPanelDataSource> QLPreviewPanelDataSourceRef;
typedef QLPreviewView *QLPreviewViewRef;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
typedef QLFilePreviewRequest *QLFilePreviewRequestRef;
API_AVAILABLE(macos(12.0))
typedef QLPreviewReply *QLPreviewReplyRef;
API_AVAILABLE(macos(12.0))
typedef QLPreviewReplyAttachment *QLPreviewReplyAttachmentRef;
#endif// 120000

typedef NSTitlebarAccessoryViewController *TitlebarAccessoryViewControllerRef;

typedef CFRunLoopTimerRef TimerRef;


#pragma mark - header imports

#import "CUI_AppDelegate.h"

//#import "CUI_RequiredHeaders.h"// 20240923

#import "AdaptiveImageGlyph.h"
#import "AffineTransform.h"
#import "Alert.h"
#import "Animation.h"
#import "AnimationContext.h"
#import "Appearance.h"
#import "AppleEventDescriptor.h"
#import "AppleEventManager.h"
#import "AppleScript.h"
//#import "AutoreleasePool.h"

#import "Window.h"

#import "Application.h"
#import "Array.h"
#import "AttributedString.h"
//#import "AttributeDescription.h"

#import "BackgroundActivityScheduler.h"
#import "BezierPath.h"
#import "BitmapImageRep.h"
#import "BitVector.h"
#import "Box.h"
#import "Browser.h"
#import "BrowserCell.h"
#import "Bundle.h"
#import "Button.h"
#import "ByteCountFormatter.h"

#import "CAAnimation.h"
#import "CADisplayLink.h"
#import "CAEmitterCell.h"
#import "CAEmitterLayer.h"
#import "CAGradientLayer.h"
#import "CALayer.h"
#import "Calendar.h"
#import "CAMediaTiming.h"
#import "CAMediaTimingFunction.h"
#import "CAReplicatorLayer.h"
#import "CAScrollLayer.h"
#import "CAShapeLayer.h"
#import "CATextLayer.h"
#import "CATiledLayer.h"
#import "CATransaction.h"
#import "CATransform3D.h"
#import "CATransformLayer.h"
#import "CAValueFunction.h"
#import "Cell.h"
#import "CharacterSet.h"
#import "ClickGestureRecognizer.h"
#import "ClipView.h"
#import "Coder.h"
#import "Color.h"
#import "ColorList.h"
#import "ColorPanel.h"
#import "ColorSampler.h"
#import "ColorSpace.h"
#import "ColorWell.h"
#import "ComboBox.h"
#import "ComboButton.h"
#import "ComparisonPredicate.h"
#import "CompoundPredicate.h"
#import "Control.h"
//#import "CoreData.h"
#import "Cursor.h"

#import "Data.h"
#import "Date.h"
#import "DateComponentsFormatter.h"
#import "DateFormatter.h"
#import "DateInterval.h"
#import "DateIntervalFormatter.h"
#import "DatePicker.h"
#import "DecimalNumber.h"
#import "DialogEvent.h"
#import "Dictionary.h"
#import "DistributedLock.h"
#import "DistributedNotificationCenter.h"
#import "DockTile.h"
//#import "Document.h"
//#import "DocumentController.h"
#import "DraggingInfo.h"
#import "DraggingItem.h"
#import "DraggingSession.h"

#import "Enumerator.h"
#import "Error.h"
#import "Event.h"
#import "Exception.h"
#import "Expression.h"
#import "ExtensionContext.h"
#import "ExtensionRequestHandling.h"

#import "FileHandle.h"
#import "FileManager.h"
#import "FileWrapper.h"
#import "Font.h"
#import "FontDescriptor.h"
#import "FontManager.h"
#import "Formatter.h"

#import "Geometry.h"
#import "GestureRecognizer.h"
#import "GlyphGenerator.h"
#import "Gradient.h"
#import "Graphics.h"
#import "GraphicsContext.h"
#import "GridView.h"

#import "HashTable.h"
#import "HelpManager.h"

#import "Image.h"
#import "ImageRep.h"
#import "ImageView.h"
#import "IndexPath.h"
#import "IndexSet.h"
#import "Inkey.h"
#import "Input.h"
#import "Invocation.h"
#import "ISO8601DateFormatter.h"
#import "ItemProvider.h"

#import "JSONSerialization.h"

#import "KeyedArchiver.h"
#import "KeyValueCoding.h"
#import "KeyValueObserving.h"

#import "LayoutAnchor.h"
#import "LayoutConstraint.h"
#import "LayoutGuide.h"
#import "LayoutManager.h"
#import "LevelIndicator.h"
#import "LinguisticTagger.h"
#import "ListFormatter.h"
#import "Locale.h"
#import "LocalizedNumberFormatRule.h"
#import "Lock.h"

#import "MagnificationGestureRecognizer.h"
#import "MapTable.h"
#import "MDA.h"
#import "Measurement.h"
#import "MeasurementFormatter.h"
#import "MediaLibraryBrowserController.h"
#import "Menu.h"
#import "MenuItem.h"
#import "MenuItemBadge.h"
#import "MenuToolbarItem.h"
#import "MethodSignature.h"

#import "Nib.h"
#import "Notification.h"
#import "NotificationQueue.h"
#import "NumberFormatter.h"

#import "ObjCRuntime.h"
#import "Object.h"

#import "SavePanel.h"

#import "OpenPanel.h"
#import "Operation.h"
#import "OrderedCollectionChange.h"
#import "OrderedCollectionDifference.h"
#import "OrderedSet.h"
#import "Orthography.h"

#import "PageLayout.h"
#import "Panel.h"
#import "PanGestureRecognizer.h"
#import "ParagraphStyle.h"
#import "Pasteboard.h"
#import "PathCell.h"
#import "PathComponentCell.h"
#import "PathControlItem.h"
#import "PathControl.h"
#import "PDFInfo.h"
#import "PDFPanel.h"
#import "PersonNameComponents.h"
#import "PersonNameComponentsFormatter.h"
#import "PointerArray.h"
#import "PointerFunctions.h"
#import "Popover.h"
#import "PopUpButton.h"
#import "Port.h"
#import "Predicate.h"
#import "PredicateEditor.h"
#import "PredicateEditorRowTemplate.h"
#import "PressGestureRecognizer.h"
#import "PressureConfiguration.h"
#import "PreviewRepresentingActivityItem.h"
#import "Printer.h"
#import "PrintInfo.h"
#import "PrintOperation.h"
#import "PrintPanel.h"
#import "ProcessInfo.h"
#import "Progress.h"
#import "ProgressIndicator.h"
#import "PropertyList.h"

//#import "QLFilePreviewRequest.h"
//#import "QLPreviewingController.h"
//#import "QLPreviewItem.h"
//#import "QLPreviewPanel.h"
//#import "QLPreviewProvider.h"
//#import "QLPreviewReply.h"
//#import "QLPreviewView.h"

#import "Range.h"
#import "RegularExpression.h"
#import "RelativeDateTimeFormatter.h"
#import "Responder.h"
#import "RotationGestureRecognizer.h"
#import "RuleEditor.h"
#import "RulerMarker.h"
#import "RulerView.h"
#import "RunLoop.h"
#import "RunningApplication.h"

#import "Scanner.h"
#import "Screen.h"
#import "ScriptWhoseTests.h"
#import "Scroller.h"
#import "ScrollView.h"
#import "SearchField.h"
#import "SearchFieldCell.h"
#import "SearchToolbarItem.h"
#import "SecureTextField.h"
#import "SegmentedControl.h"
#import "Set.h"
#import "Shadow.h"
#import "SharingCollaborationModeRestriction.h"
#import "SharingService.h"
#import "Slider.h"
#import "SortDescriptor.h"
#import "Sound.h"
#import "SpeechRecognizer.h"
#import "SpeechSynthesizer.h"
#import "SpellChecker.h"
#import "SplitView.h"
#import "SplitViewItem.h"
#import "StackView.h"
#import "StatusBar.h"
#import "StatusBarButton.h"
#import "StatusItem.h"
#import "Stepper.h"
#import "Storyboard.h"
#import "StoryboardSegue.h"
#import "Stream.h"
#import "String.h"
#import "StringDrawing.h"
#import "Switch.h"

#import "TableCellView.h"
#import "TableColumn.h"
#import "TableHeaderCell.h"
#import "TableHeaderView.h"
#import "TableRowView.h"
#import "TableView.h"

#import "OutlineView.h"

#import "TabView.h"
#import "TabViewItem.h"
#import "Task.h"
#import "TermOfAddress.h"
#import "Text.h"
#import "TextAlternatives.h"
#import "TextAttachment.h"
#import "TextCheckingClient.h"
#import "TextCheckingController.h"
#import "TextCheckingResult.h"
#import "TextContainer.h"
#import "TextContent.h"
#import "TextField.h"
#import "TextFieldCell.h"
#import "TextInputClient.h"
#import "TextInsertionIndicator.h"
#import "TextLabel.h"
#import "TextList.h"
#import "TextStorage.h"
#import "TextTable.h"
#import "TextView.h"
#import "Thread.h"
#import "Timer.h"
#import "TimeZone.h"
#import "TintConfiguration.h"
#import "TitlebarAccessoryViewController.h"
#import "TokenField.h"
#import "Toolbar.h"
#import "ToolbarItem.h"
#import "ToolbarItemGroup.h"
#import "Touch.h"
#import "TrackingArea.h"
#import "TrackingSeparatorToolbarItem.h"

#import "UbiquitousKeyValueStore.h"
#import "UndoManager.h"
#import "Unit.h"
#import "URL.h"
#import "URLCache.h"
#import "URLRequest.h"
#import "URLResponse.h"
#import "URLSession.h"
#import "UserActivity.h"
#import "UserDefaults.h"
#import "UserDefaultsController.h"
#import "UserInterfaceItemIdentification.h"
#import "UserNotification.h"
#import "UserScriptTask.h"
#import "UUID.h"

#import "Value.h"
#import "View.h"
#import "ViewController.h"
#import "VisualEffectView.h"

#import "WindowController.h"
#import "WindowTab.h"
#import "WindowTabGroup.h"
#import "Workspace.h"


#pragma mark - runtime alert
void CUI_ShowAlert( NSAlertStyle style, NSString *msg, NSString *info );
void CUI_ShowWindowDoesNotExistAlert( NSInteger tag );

// on error fn 20201221
typedef void (*CUI_OnErrorFunctionType)(NSInteger,NSInteger);
static CUI_OnErrorFunctionType sCUI_OnErrorFunction;
CUI_OnErrorFunctionType CUI_OnErrorFunction( void );
void CUI_SetOnErrorFunction( CUI_OnErrorFunctionType onErrorFn );
void CallUserDefinedOnErrorFunction( long fileID, long errCode );

#pragma mark - utilities
NSColor *CUI_FixColor( long col );
CGPathRef CUI_BezierPathCGPath( NSBezierPath *bezierPath );
NSBezierPath *CUI_BezierPathWithCGPath( CGPathRef cgPath );
NSString *CUI_PathForResource( NSString *name );
NSImage *CUI_ImageResource( NSString *path );
NSImage *CUI_FixImageValue( CFTypeRef inImage );
NSSound *CUI_SoundResource( NSString *path );// 20240725
NSFont *CUI_FixFont( const void *inFont );
CFRange NSRangeToCFRange( NSRange range );
NSRange NSRangeFromCFRange( CFRange range );
