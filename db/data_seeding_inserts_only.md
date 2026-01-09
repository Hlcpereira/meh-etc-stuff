# Data Seeding - INSERT Statements Only

*Contains only INSERT and SET IDENTITY_INSERT statements*

## Summary

- **Total INSERT Blocks:** 2166

---

## INSERT Statements

### Block 1

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (1, N'Contains', NULL)
```

---

### Block 2

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (2, N'Equals', N'=')
```

---

### Block 3

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (3, N'Different', N'<>')
```

---

### Block 4

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (4, N'Greater than', N'>')
```

---

### Block 5

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (5, N'Greater than OR equals', N'>=')
```

---

### Block 6

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (6, N'Less than', N'<')
```

---

### Block 7

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (7, N'Less than OR equals', N'<=')
```

---

### Block 8

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (8, N'Interval', NULL)
```

---

### Block 9

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (9, N'StartsWith', NULL)
```

---

### Block 10

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (10, N'EndsWith', NULL)
```

---

### Block 11

```sql
INSERT [dbo].[PoliciesCompareTypes] ([PolicyCompareTypeID], [PolicyCompareTypeName], [Symbol]) VALUES (11, N'NotContais', NULL)
```

---

### Block 12

```sql
INSERT [dbo].[JobTypes] ([JobTypeID], [TypeName]) VALUES (1, N'Impressão')
```

---

### Block 13

```sql
INSERT [dbo].[JobTypes] ([JobTypeID], [TypeName]) VALUES (2, N'Cópia')
```

---

### Block 14

```sql
INSERT [dbo].[JobTypes] ([JobTypeID], [TypeName]) VALUES (3, N'Fax Recebido')
```

---

### Block 15

```sql
INSERT [dbo].[JobTypes] ([JobTypeID], [TypeName]) VALUES (4, N'Scan')
```

---

### Block 16

```sql
INSERT [dbo].[JobTypes] ([JobTypeID], [TypeName]) VALUES (5, N'Fax Enviado')
```

---

### Block 17

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (1, N'Title')
```

---

### Block 18

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (2, N'PrintApplication')
```

---

### Block 19

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (3, N'TotalPages')
```

---

### Block 20

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (4, N'Copy')
```

---

### Block 21

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (5, N'Duplex')
```

---

### Block 22

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (6, N'Color')
```

---

### Block 23

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (7, N'PaperSize')
```

---

### Block 24

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (8, N'PrintQuality')
```

---

### Block 25

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (9, N'Times')
```

---

### Block 26

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (10, N'SpoolSize')
```

---

### Block 27

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (11, N'CostValue')
```

---

### Block 28

```sql
INSERT [dbo].[PoliciesFeatures] ([PolicyFeatureID], [PolicyFeatureName]) VALUES (12, N'DayOfWeek')
```

---

### Block 29

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (1, NULL, NULL, NULL, 0, 0, NULL)
```

---

### Block 30

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (0, NULL, NULL, NULL, 0, 0, 1)
```

---

### Block 31

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (1, NULL, NULL, NULL, 0, 0, NULL)
```

---

### Block 32

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (0, NULL, NULL, NULL, 0, 0, 1)
```

---

### Block 33

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (1, NULL, NULL, NULL, 0, 0, NULL)
```

---

### Block 34

```sql
INSERT [dbo].[PrintersDevicesCountersConfig] ([IsLifeCounter], [PrinterBrandID], [ModelID], [PrinterDeviceID], [AdjustType], [ComplementType], [ProductionIsLife]) VALUES (0, NULL, NULL, NULL, 0, 0, 1)
```

---

### Block 35

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (1, N'Permissions', N'Allow')
```

---

### Block 36

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (2, N'Permissions', N'AllowOnly')
```

---

### Block 37

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (3, N'Permissions', N'Confirmation')
```

---

### Block 38

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (4, N'Permissions', N'Alert')
```

---

### Block 39

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (5, N'Permissions', N'Deny')
```

---

### Block 40

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (6, N'Security', N'StampLogon')
```

---

### Block 41

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (7, N'Security', N'AuditJobContent')
```

---

### Block 42

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (8, N'Converter', N'ConvertToMono')
```

---

### Block 43

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (9, N'Converter', N'ConvertToDuplex')
```

---

### Block 44

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (10, N'Security', N'StampLogonStatus')
```

---

### Block 45

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (11, N'Security', N'AuditJobContentStatus')
```

---

### Block 46

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (12, N'Converter', N'ConvertToMonoNotify')
```

---

### Block 47

```sql
INSERT [dbo].[PoliciesBehaviors] ([PolicyBehaviorID], [PolicyBehaviorType], [PolicyBehaviorName]) VALUES (13, N'Converter', N'ConvertToDuplexNotify')
```

---

### Block 48

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (0, N'None')
```

---

### Block 49

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (1, N'Reports')
```

---

### Block 50

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (2, N'Management')
```

---

### Block 51

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (3, N'CanLogin')
```

---

### Block 52

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (4, N'Supplies')
```

---

### Block 53

```sql
INSERT [dbo].[PermissionControls] ([PermissionControlID], [PermissionControlName]) VALUES (5, N'Inventory')
```

---

### Block 54

```sql
INSERT [dbo].[PermissionAccesses] ([PermissionAccessID], [PermissionAccessName]) VALUES (0, N'Denied')
```

---

### Block 55

```sql
INSERT [dbo].[PermissionAccesses] ([PermissionAccessID], [PermissionAccessName]) VALUES (1, N'Restrict')
```

---

### Block 56

```sql
INSERT [dbo].[PermissionAccesses] ([PermissionAccessID], [PermissionAccessName]) VALUES (9, N'AllAccess')
```

---

### Block 57

```sql
INSERT [dbo].[DomainTypes] ([DomainTypeID], [DomainTypeName]) VALUES (1, N'IntegratedDomain')
```

---

### Block 58

```sql
INSERT [dbo].[DomainTypes] ([DomainTypeID], [DomainTypeName]) VALUES (2, N'PopulatedDomain')
```

---

### Block 59

```sql
INSERT [dbo].[DomainTypes] ([DomainTypeID], [DomainTypeName]) VALUES (3, N'UsersLocalMachines')
```

---

### Block 60

```sql
INSERT [dbo].[DomainTypes] ([DomainTypeID], [DomainTypeName]) VALUES (4, N'SystemDomain')
```

---

### Block 61

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (0, N'Unknown', 1)
```

---

### Block 62

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (1, N'Letter 8 1/2 x 11 in', 1)
```

---

### Block 63

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (2, N'Letter Small 8 1/2 x 11 in', 0)
```

---

### Block 64

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (3, N'Tabloid 11 x 17 in', 0)
```

---

### Block 65

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (4, N'Ledger 17 x 11 in', 0)
```

---

### Block 66

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (5, N'Legal 8 1/2 x 14 in', 0)
```

---

### Block 67

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (6, N'Statement 5 1/2 x 8 1/2 in', 0)
```

---

### Block 68

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (7, N'Executive 7 1/4 x 10 1/2 in', 0)
```

---

### Block 69

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (8, N'A3 297 x 420 mm', 0)
```

---

### Block 70

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (9, N'A4  210 x 297 mm', 1)
```

---

### Block 71

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (10, N'A4 Small 210 x 297 mm', 0)
```

---

### Block 72

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (11, N'A5 148 x 210 mm', 0)
```

---

### Block 73

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (12, N'B4 (JIS) 250 x 354', 0)
```

---

### Block 74

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (13, N'B5 (JIS) 182 x 257 mm', 0)
```

---

### Block 75

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (14, N'Folio 8 1/2 x 13 in', 0)
```

---

### Block 76

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (15, N'Quarto 215 x 275 mm', 0)
```

---

### Block 77

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (16, N'10 x 14 in', 0)
```

---

### Block 78

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (17, N'11 x 17 in', 0)
```

---

### Block 79

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (18, N'Note 8 1/2 x 11 in', 0)
```

---

### Block 80

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (19, N'Envelope #9 3 7/8 x 87/8', 0)
```

---

### Block 81

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (20, N'Envelope #10 4 1/8 x 9 1/2', 0)
```

---

### Block 82

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (21, N'Envelope #11 4 1/2 x 10 3/8', 0)
```

---

### Block 83

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (22, N'Envelope #12 4 \276 x 11', 0)
```

---

### Block 84

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (23, N'Envelope #14 5 x 11 1/2', 0)
```

---

### Block 85

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (24, N'C size sheet', 0)
```

---

### Block 86

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (25, N'D size sheet', 0)
```

---

### Block 87

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (26, N'E size sheet', 0)
```

---

### Block 88

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (27, N'Envelope DL 110 x 220 mm', 0)
```

---

### Block 89

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (28, N'Envelope C5 162 x 229 mm', 0)
```

---

### Block 90

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (29, N'Envelope C3 324 x 458 mm', 0)
```

---

### Block 91

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (30, N'Envelope C4 229 x 324 mm', 0)
```

---

### Block 92

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (31, N'Envelope C6 114 x 162 mm', 0)
```

---

### Block 93

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (32, N'Envelope C65 114 x 229 mm', 0)
```

---

### Block 94

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (33, N'Envelope B4 250 x 353 mm', 0)
```

---

### Block 95

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (34, N'Envelope B5 176 x 250 mm', 0)
```

---

### Block 96

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (35, N'Envelope B6 176 x 125 mm', 0)
```

---

### Block 97

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (36, N'Envelope 110 x 230 mm', 0)
```

---

### Block 98

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (37, N'Envelope Monarch 3.875 x 7.5 in', 0)
```

---

### Block 99

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (38, N'6 3/4 Envelope 3 5/8 x 6 1/2 in', 0)
```

---

### Block 100

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (39, N'US Std Fanflod 14 7/8 x 11 in', 0)
```

---

### Block 101

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (40, N'German Std Fanfold 8 1/2 x 12 in', 0)
```

---

### Block 102

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (41, N'German Legal Fanfold 8 1/2 x 13 in', 0)
```

---

### Block 103

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (42, N'B4 (ISO) 250 x 353 mm', 0)
```

---

### Block 104

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (43, N'Japanese Postcard 100 x 148 mm', 0)
```

---

### Block 105

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (44, N'9 x 11 in', 0)
```

---

### Block 106

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (45, N'10 x 11 in', 0)
```

---

### Block 107

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (46, N'15 x 11 in', 0)
```

---

### Block 108

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (47, N'Envelop invite 220 x 220 mm', 0)
```

---

### Block 109

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (48, N'RESERVED--DO NOT USE', 0)
```

---

### Block 110

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (49, N'RESERVED--DO NOT USE', 0)
```

---

### Block 111

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (50, N'Letter Extra 9 \275 x 12 in', 0)
```

---

### Block 112

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (51, N'Legal Extra 11.69 x 15 in', 0)
```

---

### Block 113

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (52, N'Tabloid Extra 11.69 x 18 in', 0)
```

---

### Block 114

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (53, N'A4 Extra 9.27 x 12.69 in', 0)
```

---

### Block 115

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (54, N'Letter Transverse 9 \275 x 11 in', 0)
```

---

### Block 116

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (55, N'A4 trasverse 210 x 297 mm', 0)
```

---

### Block 117

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (56, N'Letter Extra Transverse 9 \275 x 12 in', 0)
```

---

### Block 118

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (57, N'SuperA/SuperA/A4 227 x 356 mm', 0)
```

---

### Block 119

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (58, N'SuperB/SuperB/A3 305 x 487 mm', 0)
```

---

### Block 120

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (59, N'Letter Plus 8.5 x 12.69 in', 0)
```

---

### Block 121

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (60, N'A4 Plus 210 x 330 mm', 0)
```

---

### Block 122

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (61, N'A5 transverse 148 x 210 mm', 0)
```

---

### Block 123

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (62, N'B5 (JIS) transverse 182 x 257 mm', 0)
```

---

### Block 124

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (63, N'A3 Extra 322 x 445 mm', 0)
```

---

### Block 125

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (64, N'A5 Extra 174 x 235 mm', 0)
```

---

### Block 126

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (65, N'B5 (ISO) Extra 201 x 276 mm', 0)
```

---

### Block 127

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (66, N'A2 420 x 594 mm', 0)
```

---

### Block 128

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (67, N'A3 transverse 297 x 420 mm', 0)
```

---

### Block 129

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (68, N'A3 Extra Transverse 322 x 445 mm', 0)
```

---

### Block 130

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (69, N'Japanese Double Postcard 200 x 148 mm', 0)
```

---

### Block 131

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (70, N'A6 105 x 148 mm', 0)
```

---

### Block 132

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (71, N'Japanese Envelope Kaku #2', 0)
```

---

### Block 133

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (72, N'Japanese Envelope KAku #3', 0)
```

---

### Block 134

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (73, N'Japanese Envelope Kaku #3', 0)
```

---

### Block 135

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (74, N'Japanese Envelope Kaku #4', 0)
```

---

### Block 136

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (75, N'Letter Rotated 11 x 8 1/2 11 in', 0)
```

---

### Block 137

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (76, N'A3 Rotated 420 x 297 mm', 0)
```

---

### Block 138

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (77, N'A4 Rotated 297 x 210 mm', 0)
```

---

### Block 139

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (78, N'A5 Rotated 210 x 148 mm', 0)
```

---

### Block 140

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (79, N'B4 (JIS) Rotated 364 x 257 mm', 0)
```

---

### Block 141

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (80, N'B5 (JIS) Rotated 257 x 182 mm', 0)
```

---

### Block 142

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (81, N'Japanese Postcard Rotated 148 x 100 mm', 0)
```

---

### Block 143

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (82, N'Double Japanese Postcard Rotated 148 x 100 mm', 0)
```

---

### Block 144

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (83, N'A6 Rotated 148 x 105 mm', 0)
```

---

### Block 145

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (84, N'Japanese Envelope Kaku #2 Rotated', 0)
```

---

### Block 146

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (85, N'Japanese Envelope Kaku #3 Rotated', 0)
```

---

### Block 147

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (86, N'Japanese Envelope Chou #3 rotated', 0)
```

---

### Block 148

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (87, N'Japanese Envelope Chou #4 Rotated', 0)
```

---

### Block 149

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (88, N'B6 (JIS) 128 x 182 mm', 0)
```

---

### Block 150

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (89, N'B6 (JIS) rotated 182 x 128 mm', 0)
```

---

### Block 151

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (90, N'12 x 11 in', 0)
```

---

### Block 152

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (91, N'Japanese envelope You #4', 0)
```

---

### Block 153

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (92, N'Japanese Envelope You #4 Rotated', 0)
```

---

### Block 154

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (93, N'PRC 16 k 146 x 215 mm', 0)
```

---

### Block 155

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (94, N'PRC 32k 97 x 151 mm', 0)
```

---

### Block 156

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (95, N'PRC 32 k (Big) 97 x 151 mm', 0)
```

---

### Block 157

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (96, N'PRC Envelope #1 102 x 165 mm', 0)
```

---

### Block 158

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (97, N'PRC Envelope #2 102 x 176 mm', 0)
```

---

### Block 159

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (98, N'PRC Envelope #3 125 x 176 mm', 0)
```

---

### Block 160

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (99, N'PRC Envelope #4 110 x 208 mm', 0)
```

---

### Block 161

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (100, N'PRC Envelope #5 110 x 220 mm', 0)
```

---

### Block 162

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (101, N'PRC Envelope #6 120 x 230 mm', 0)
```

---

### Block 163

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (102, N'PRC Envelope #7 160 x 230 mm', 0)
```

---

### Block 164

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (103, N'PRC Envelope #8 120 x 309 mm', 0)
```

---

### Block 165

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (104, N'PRC Envelope #9 229 x 324 mm', 0)
```

---

### Block 166

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (105, N'PRC envelope #10 324 x 458 mm', 0)
```

---

### Block 167

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (106, N'PRC 16k Rotated', 0)
```

---

### Block 168

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (107, N'PRC 32k Rotated', 0)
```

---

### Block 169

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (108, N'PRC 32k(Big) Rotated', 0)
```

---

### Block 170

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (109, N'PRC Envelope #1 Rotated 165 x 102 mm', 0)
```

---

### Block 171

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (110, N'PRC Envelope #2 Rotated 176 x 102 mm', 0)
```

---

### Block 172

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (111, N'PRC Envelope #3 Rotated 176 x 125 mm', 0)
```

---

### Block 173

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (112, N'PRC Envelope #4 Rotated 208 x 110 mm', 0)
```

---

### Block 174

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (113, N'PRC Envelope #5 Rotated 220 x 110 mm', 0)
```

---

### Block 175

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (114, N'PRC Envelope #6 Rotated 230 x 120 mm', 0)
```

---

### Block 176

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (115, N'PRC Envelope #7 Rotated 230 x 160 mm', 0)
```

---

### Block 177

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (116, N'PRC Envelope #8 Rotated 309 x 120 mm', 0)
```

---

### Block 178

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (117, N'PRC Envelope #9 Rotated 324 x 229 mm', 0)
```

---

### Block 179

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (118, N'PRC Envelope #10 Rotated 458 x 324 mm', 0)
```

---

### Block 180

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (256, N'User-Defined', 1)
```

---

### Block 181

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (500, N'A0 840 x 1188 mm', 0)
```

---

### Block 182

```sql
INSERT [dbo].[PapersSize] ([PaperSizeID], [PaperSizeName], [DefaultShowPaperSize]) VALUES (501, N'A1 594 x 840 mm', 0)
```

---

### Block 183

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (-4, N'Alta', N'360PrintQualityHigh')
```

---

### Block 184

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (-3, N'Média', N'360PrintQualityAverage')
```

---

### Block 185

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (-2, N'Baixa', N'360PrintQualityLow')
```

---

### Block 186

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (-1, N'Rascunho', N'360PrintQualityDraft')
```

---

### Block 187

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (0, N'0 dpi', NULL)
```

---

### Block 188

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (96, N'96 dpi', NULL)
```

---

### Block 189

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (120, N'120 dpi', NULL)
```

---

### Block 190

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (150, N'150 dpi', NULL)
```

---

### Block 191

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (180, N'180 dpi', NULL)
```

---

### Block 192

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (200, N'200 dpi', NULL)
```

---

### Block 193

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (240, N'240 dpi', NULL)
```

---

### Block 194

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (300, N'300 dpi', NULL)
```

---

### Block 195

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (360, N'360 dpi', NULL)
```

---

### Block 196

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (600, N'600 dpi', NULL)
```

---

### Block 197

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (720, N'720 dpi', NULL)
```

---

### Block 198

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (900, N'900 dpi', NULL)
```

---

### Block 199

```sql
INSERT [dbo].[PrintQualities] ([PrintQualityID], [PrintQualityName], [PrintQualityResource]) VALUES (1200, N'1200 dpi', NULL)
```

---

### Block 200

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (1, N'PrinterDeviceID')
```

---

### Block 201

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (2, N'PrinterDeviceName')
```

---

### Block 202

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (3, N'SerialNumber')
```

---

### Block 203

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (4, N'AddressName')
```

---

### Block 204

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (5, N'AddressPort')
```

---

### Block 205

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (6, N'AddressMAC')
```

---

### Block 206

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (7, N'PrinterModelID')
```

---

### Block 207

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (8, N'IsLocal')
```

---

### Block 208

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (9, N'IsUSBPort')
```

---

### Block 209

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (10, N'SiteID')
```

---

### Block 210

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (11, N'SiteDivisionID')
```

---

### Block 211

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (12, N'Location')
```

---

### Block 212

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (13, N'CostGroupID')
```

---

### Block 213

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (14, N'CostAccountID')
```

---

### Block 214

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (15, N'ForceColor')
```

---

### Block 215

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (16, N'TrustOrigin')
```

---

### Block 216

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (17, N'EnabledBillingStatus')
```

---

### Block 217

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (18, N'EnabledCounterStatus')
```

---

### Block 218

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (19, N'EngagedStatus')
```

---

### Block 219

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (20, N'PrinterDeviceMainID')
```

---

### Block 220

```sql
INSERT [dbo].[PrintersDevicesAuditingFields] ([AuditingFieldID], [AuditingFieldValue]) VALUES (21, N'FirmwareVersion')
```

---

### Block 221

```sql
INSERT [dbo].[PrintersDevicesAuditingActions] ([AuditingActionID], [AuditingActionName]) VALUES (1, N'Creation')
```

---

### Block 222

```sql
INSERT [dbo].[PrintersDevicesAuditingActions] ([AuditingActionID], [AuditingActionName]) VALUES (2, N'Update')
```

---

### Block 223

```sql
INSERT [dbo].[PrintersDevicesAuditingSources] ([AuditingSourceID], [AuditingSourceName]) VALUES (1, N'NPL')
```

---

### Block 224

```sql
INSERT [dbo].[PrintersDevicesAuditingSources] ([AuditingSourceID], [AuditingSourceName]) VALUES (2, N'NSL')
```

---

### Block 225

```sql
INSERT [dbo].[PrintersDevicesAuditingSources] ([AuditingSourceID], [AuditingSourceName]) VALUES (3, N'NPA')
```

---

### Block 226

```sql
INSERT [dbo].[PrintersDevicesAuditingSources] ([AuditingSourceID], [AuditingSourceName]) VALUES (4, N'nServer')
```

---

### Block 227

```sql
INSERT [dbo].[PrintersDevicesAuditingSources] ([AuditingSourceID], [AuditingSourceName]) VALUES (5, N'GP')
```

---

### Block 228

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (0, N'Unknown')
```

---

### Block 229

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (1, N'Windows 95')
```

---

### Block 230

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (2, N'Windows 98')
```

---

### Block 231

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (3, N'Windows NT')
```

---

### Block 232

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (4, N'Windows 2000')
```

---

### Block 233

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (5, N'Windows XP')
```

---

### Block 234

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (6, N'Windows 2003')
```

---

### Block 235

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (7, N'Linux')
```

---

### Block 236

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (8, N'Windows ME')
```

---

### Block 237

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (9, N'Windows Vista')
```

---

### Block 238

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (10, N'FreeBSD')
```

---

### Block 239

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (11, N'Windows 2008')
```

---

### Block 240

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (12, N'Macintosh')
```

---

### Block 241

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (13, N'Windows 7')
```

---

### Block 242

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (14, N'Windows 2008 R2')
```

---

### Block 243

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (15, N'Windows 2012')
```

---

### Block 244

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (16, N'Windows 8')
```

---

### Block 245

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (17, N'Windows 10')
```

---

### Block 246

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (18, N'Windows 2016')
```

---

### Block 247

```sql
INSERT [dbo].[OperationSystems] ([OperationSystemID], [OperationSystemName]) VALUES (19, N'Windows 2019')
```

---

### Block 248

```sql
SET IDENTITY_INSERT [dbo].[Sites] ON
```

---

### Block 249

```sql
INSERT [dbo].[Sites] ([SiteID], [SiteName], [IsDefault]) VALUES (1, N'Default', 1)
```

---

### Block 250

```sql
SET IDENTITY_INSERT [dbo].[Sites] OFF
```

---

### Block 251

```sql
INSERT [dbo].[Products] ([ProductID], [ProductName]) VALUES (1, N'n-Inventory')
```

---

### Block 252

```sql
INSERT [dbo].[Products] ([ProductID], [ProductName]) VALUES (2, N'n-Client')
```

---

### Block 253

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (1, N'Life', 2)
```

---

### Block 254

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (2, N'Type', 3)
```

---

### Block 255

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (3, N'Orientation', 4)
```

---

### Block 256

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (4, N'Digitalization', 5)
```

---

### Block 257

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (5, N'Paper', 6)
```

---

### Block 258

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (6, N'Other', 7)
```

---

### Block 259

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (7, N'Plotter', 8)
```

---

### Block 260

```sql
INSERT [dbo].[CounterTypeGroups] ([CounterGroupID], [CounterGroupName], [ToOrder]) VALUES (8, N'Production', 1)
```

---

### Block 261

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (1, N'General', N'@@Life', 1, 1)
```

---

### Block 262

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (2, N'Print', N'@@GPVPrinting', 2, 1)
```

---

### Block 263

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (3, N'Copies', N'@@Copies', 2, 1)
```

---

### Block 264

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (4, N'Fax', N'Fax', 2, 1)
```

---

### Block 265

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (5, N'Scan', N'Scan', 4, 1)
```

---

### Block 266

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (6, N'Copy', N'@@Copies', 2, 1)
```

---

### Block 267

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (7, N'Duplex', N'Duplex', 3, 1)
```

---

### Block 268

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (8, N'FaxReceived', N'FaxReceived', 2, 1)
```

---

### Block 269

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (9, N'FaxSent', N'FaxSent', 4, 1)
```

---

### Block 270

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (10, N'A3', N'A3', 5, 1)
```

---

### Block 271

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (11, N'A3AndBiggerSizes', N'A3AndBiggerSizes', 5, 1)
```

---

### Block 272

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (12, N'A4', N'A4', 5, 1)
```

---

### Block 273

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (13, N'A5', N'A5', 5, 1)
```

---

### Block 274

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (14, N'Letter', N'Letter', 5, 1)
```

---

### Block 275

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (15, N'Oficio', N'Oficio', 5, 1)
```

---

### Block 276

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (16, N'Executive', N'Executive', 5, 1)
```

---

### Block 277

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (17, N'A4Fax', N'A4Fax', 6, 1)
```

---

### Block 278

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (18, N'A3Fax', N'A3Fax', 6, 1)
```

---

### Block 279

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (19, N'A4Copy', N'A4Copy', 6, 1)
```

---

### Block 280

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (20, N'A4Print', N'A4Print', 6, 1)
```

---

### Block 281

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (21, N'A3Copy', N'A3Copy', 6, 1)
```

---

### Block 282

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (22, N'A3Print', N'A3Print', 6, 1)
```

---

### Block 283

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (23, N'A3FaxReceived', N'A3FaxReceived', 6, 1)
```

---

### Block 284

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (24, N'A4FaxReceived', N'A4FaxReceived', 6, 1)
```

---

### Block 285

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (25, N'PlotterGeneralM2', N'PlotterGeneralM2', 7, 2)
```

---

### Block 286

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (26, N'PlotterGeneralMl', N'PlotterGeneralMl', 7, 3)
```

---

### Block 287

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (27, N'ScanToCopy', N'ScanToCopy', 4, 1)
```

---

### Block 288

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (28, N'ScanToStorage', N'ScanToStorage', 4, 1)
```

---

### Block 289

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (29, N'ScanToFax', N'ScanToFax', 4, 1)
```

---

### Block 290

```sql
INSERT [dbo].[CounterTypes] ([CounterTypeID], [CounterTypeName], [Description], [CounterGroupID], [CounterUnitID]) VALUES (30, N'Production', N'@@Production', 8, 1)
```

---

### Block 291

```sql
INSERT [dbo].[PrinterQueueTypes] ([PrinterQueueTypeID], [PrinterQueueTypeName]) VALUES (1, N'Local')
```

---

### Block 292

```sql
INSERT [dbo].[PrinterQueueTypes] ([PrinterQueueTypeID], [PrinterQueueTypeName]) VALUES (2, N'Shared')
```

---

### Block 293

```sql
INSERT [dbo].[PrinterQueueTypes] ([PrinterQueueTypeID], [PrinterQueueTypeName]) VALUES (4, N'NetWork')
```

---

### Block 294

```sql
SET IDENTITY_INSERT [dbo].[PrintApplications] ON
```

---

### Block 295

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (0, N'-', 1, N'360Undefined')
```

---

### Block 296

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (1, N'Microsoft Word', 1, NULL)
```

---

### Block 297

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (2, N'Microsoft Excel', 1, NULL)
```

---

### Block 298

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (3, N'Microsoft PowerPoint', 1, NULL)
```

---

### Block 299

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (4, N'Browsers', 1, N'360Browsers')
```

---

### Block 300

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (5, N'Microsoft Paint', 1, NULL)
```

---

### Block 301

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (6, N'Microsoft Outlook', 1, NULL)
```

---

### Block 302

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (7, N'Bloco de Notas', 1, N'360Notepad')
```

---

### Block 303

```sql
INSERT [dbo].[PrintApplications] ([PrintApplicationID], [PrintApplicationName], [AppSystem], [PrintApplicationResource]) VALUES (8, N'PDF', 1, NULL)
```

---

### Block 304

```sql
SET IDENTITY_INSERT [dbo].[PrintApplications] OFF
```

---

### Block 305

```sql
INSERT [dbo].[JobOrigins] ([JobOriginID], [OriginName]) VALUES (1, N'Impressão direta')
```

---

### Block 306

```sql
INSERT [dbo].[JobOrigins] ([JobOriginID], [OriginName]) VALUES (2, N'DPS')
```

---

### Block 307

```sql
INSERT [dbo].[JobOrigins] ([JobOriginID], [OriginName]) VALUES (3, N'Forms')
```

---

### Block 308

```sql
INSERT [dbo].[JobOrigins] ([JobOriginID], [OriginName]) VALUES (7, N'Bureau')
```

---

### Block 309

```sql
INSERT [dbo].[PrintWays] ([PrintWayID], [PrintWayName]) VALUES (0, N'Simplex')
```

---

### Block 310

```sql
INSERT [dbo].[PrintWays] ([PrintWayID], [PrintWayName]) VALUES (1, N'Duplex')
```

---

### Block 311

```sql
INSERT [dbo].[CounterInputTypes] ([CounterInputTypeID], [CounterInputDescription]) VALUES (1, N'System')
```

---

### Block 312

```sql
INSERT [dbo].[CounterInputTypes] ([CounterInputTypeID], [CounterInputDescription]) VALUES (2, N'Manual')
```

---

### Block 313

```sql
INSERT [dbo].[CounterInputTypes] ([CounterInputTypeID], [CounterInputDescription]) VALUES (3, N'Integration')
```

---

### Block 314

```sql
SET IDENTITY_INSERT [dbo].[QuotasOperators] ON
```

---

### Block 315

```sql
INSERT [dbo].[QuotasOperators] ([OperatorID], [OperatorName], [AccountID]) VALUES (1, N'System', -1)
```

---

### Block 316

```sql
INSERT [dbo].[QuotasOperators] ([OperatorID], [OperatorName], [AccountID]) VALUES (2, N'System', -2)
```

---

### Block 317

```sql
SET IDENTITY_INSERT [dbo].[QuotasOperators] OFF
```

---

### Block 318

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (1, N'A1AccountLogin', N'Acessou o n-Server')
```

---

### Block 319

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (2, N'A2NewAccount', N'Criou novo usuário')
```

---

### Block 320

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (3, N'A3DeleteAccount', N'Deletou usuário')
```

---

### Block 321

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (4, N'A4SavedAccount', N'Salvou propriedades de usuário')
```

---

### Block 322

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (5, N'A5PasswordAccount', N'Alterou senha de usuário')
```

---

### Block 323

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (6, N'A6ControlAccount', N'Salvou propriedades de cotas de impressão de usuário')
```

---

### Block 324

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (7, N'A7HistoryCCAccount', N'Salvou histórico de conta')
```

---

### Block 325

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (8, N'A8NewCC', N'Criou nova conta')
```

---

### Block 326

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (9, N'A9DeleteCC', N'Deletou conta')
```

---

### Block 327

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (10, N'A10SavedCC', N'Salvou propriedades de conta')
```

---

### Block 328

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (11, N'A11MovedCC', N'Moveu conta')
```

---

### Block 329

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (12, N'A12ControlCC', N'Salvou controle de impressão de centro de custo')
```

---

### Block 330

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (13, N'A13DeletePrinter', N'Deletou impressora')
```

---

### Block 331

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (14, N'A14ConsolidatePrinter', N'Consolidou impressora')
```

---

### Block 332

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (15, N'A15SavedPrinter', N'Salvou propriedades da impressora')
```

---

### Block 333

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (16, N'A16NewSite', N'Criou novo site')
```

---

### Block 334

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (17, N'A17DeleteSite', N'Deletou site')
```

---

### Block 335

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (18, N'A18SavedSite', N'Salvou propriedades de site')
```

---

### Block 336

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (19, N'A19NewCost', N'Criou novo grupo de impressoras')
```

---

### Block 337

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (20, N'A20DeleteCost', N'Deletou grupo de impressoras')
```

---

### Block 338

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (21, N'A21SavedCost', N'Salvou propriedades do grupo de impressoras')
```

---

### Block 339

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (28, N'A28InstaledProducts', N'Salvou configurações gerais de ''Produtos instalados''')
```

---

### Block 340

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (29, N'A29LocalStations', N'Salvou configurações gerais de ''Estações Locais''')
```

---

### Block 341

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (30, N'A30WorkingTime', N'Salvou configurações gerais de ''Horário de Expediente'' foram salvas')
```

---

### Block 342

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (31, N'A31TrustOrigin', N'Salvou configurações gerais de ''Confiança das impressoras''')
```

---

### Block 343

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (32, N'A32ShowCostReport', N'Salvou configurações gerais de ''Exibição de custos nos relatórios''')
```

---

### Block 344

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (33, N'A33ScheduledEmails', N'Salvou configurações gerais de ''Agendamento de relatórios''')
```

---

### Block 345

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (34, N'A34NewApplication', N'Criou novo aplicativo')
```

---

### Block 346

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (35, N'A35DeleteApplication', N'Deletou aplicativo')
```

---

### Block 347

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (36, N'A36SavedApplication', N'Salvou propriedades de aplicativo')
```

---

### Block 348

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (37, N'A37WarningLicences', N'Salvou configurações de ''Avisar quando licenças expirarem''')
```

---

### Block 349

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (38, N'A38WarningProducts', N'Salvou configurações de ''Avisar quando produto instalado expirar''')
```

---

### Block 350

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (39, N'A39NewDisableRule', N'Criou nova regra para desabilitar impressora')
```

---

### Block 351

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (40, N'A40DeleteDisabledRule', N'Deletou regra para desabilitar impressora')
```

---

### Block 352

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (47, N'A47NewPrinterDevice', N'Criou uma nova impressora')
```

---

### Block 353

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (48, N'A48NewPrinterDeviceCounter', N'Criou um novo contador')
```

---

### Block 354

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (51, N'A51NewPrintPolicy', N'Criou nova política de impressão')
```

---

### Block 355

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (52, N'A52RemovedPrintPolicy', N'Removeu política de impressão')
```

---

### Block 356

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (53, N'A53SavedPrintPolicy', N'Salvou propriedades de política de impressão')
```

---

### Block 357

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (54, N'A54EnabledPrintPolicy', N'Habilitou política de impressão')
```

---

### Block 358

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (55, N'A55DisabledPrintPolicy', N'Desabilitou política de impressão')
```

---

### Block 359

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (56, N'A56NewAccountGroup', N'Criou novo grupo de usuários')
```

---

### Block 360

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (57, N'A57RemovedAccountGroup', N'Removeu grupo de usuários')
```

---

### Block 361

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (58, N'A58SavedAccountGroup', N'Salvou propriedades de grupo de usuários')
```

---

### Block 362

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (59, N'A59SavedDomain', N'Salvou propriedades de domínio')
```

---

### Block 363

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (60, N'A60GeneralsCostAccount', N'Salvou configurações gerais de ''Contas''')
```

---

### Block 364

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (61, N'A61SavedPrintQuotasGeneral', N'Salvou configurações gerais de ''Cotas de impressão''')
```

---

### Block 365

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (62, N'A62SavedPinCodeGeneral', N'Salvou configurações gerais de ''Credenciais de autenticação''')
```

---

### Block 366

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (63, N'A63SecurePinCodeAccount', N'Alterou código PIN seguro de usuário')
```

---

### Block 367

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (64, N'A64SavedPrintPolicyConfig', N'Salvou configurações de ''Políticas de impressão''')
```

---

### Block 368

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (65, N'A65SavedReleaserStorageQuota', N'Salvou configurações de ''Limitar a utilização de espaço em disco no nddPrint Releaser''')
```

---

### Block 369

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (66, N'A66AddedPrintQuotasCreditViaPrepaidCard', N'Adicionou crédito de cotas de impressão via cartão pré-pago')
```

---

### Block 370

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (67, N'A67ChangesInTheAssignmentOfPrepaidCards', N'Alteração na atribuição dos cartões pré-pagos')
```

---

### Block 371

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (68, N'A68BillingDisable', N'Salvou configurações gerais de ''Desativar contabilização''')
```

---

### Block 372

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (69, N'A69ChangedPrintQuotasPaymentsFee', N'Alterou a taxa de transação da compra de créditos de cotas de impressão')
```

---

### Block 373

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (70, N'A70SavedGeneralPermissionsQuotasManagers', N'Salvou as permissões gerais de cotas dos gerentes')
```

---

### Block 374

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (71, N'A71SavedGeneralPermissionsPoliciesManagers', N'Salvou as permissões gerais de políticas dos gerentes')
```

---

### Block 375

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (72, N'A72SavedPermissionsPoliciesManagers', N'Salvou as permissões de políticas do gerente')
```

---

### Block 376

```sql
INSERT [dbo].[AuditingActions] ([AuditingActionID], [AuditingName], [AuditingDescription]) VALUES (73, N'A73SavedPermissionsQuotasManagers', N'Salvou as permissões de cotas do gerente')
```

---

### Block 377

```sql
SET IDENTITY_INSERT [dbo].[CostGroups] ON
```

---

### Block 378

```sql
INSERT [dbo].[CostGroups] ([CostGroupID], [CostGroupName], [CostMono], [CostColor], [CostDuplexMono], [CostDuplexColor], [CostScan], [CostSentFax], [IsDefault]) VALUES (1, N'Default', CAST(0.000000 AS Decimal(19, 6)), CAST(0.000000 AS Decimal(19, 6)), CAST(0.000000 AS Decimal(19, 6)), CAST(0.000000 AS Decimal(19, 6)), CAST(0.000000 AS Decimal(19, 6)), CAST(0.000000 AS Decimal(19, 6)), 1)
```

---

### Block 379

```sql
SET IDENTITY_INSERT [dbo].[CostGroups] OFF
```

---

### Block 380

```sql
SET IDENTITY_INSERT [dbo].[PrintApplicationsRules] ON
```

---

### Block 381

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (1, 1, N'Microsoft Word - ', 1, 0, 1, 0, 1)
```

---

### Block 382

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (2, 1, N'Word - ', 1, 0, 1, 0, 1)
```

---

### Block 383

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (3, 1, N'.doc', 0, 1, 1, 0, 1)
```

---

### Block 384

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (4, 1, N'.dot', 0, 1, 1, 0, 1)
```

---

### Block 385

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (5, 1, N'.rtf', 0, 1, 1, 0, 1)
```

---

### Block 386

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (6, 1, N'.docx', 0, 1, 1, 0, 1)
```

---

### Block 387

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (7, 1, N'.docm', 0, 1, 1, 0, 1)
```

---

### Block 388

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (8, 2, N'Microsoft Excel - ', 1, 0, 1, 0, 1)
```

---

### Block 389

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (9, 2, N'Excel - ', 1, 0, 1, 0, 1)
```

---

### Block 390

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (10, 2, N'.csv', 0, 1, 1, 0, 1)
```

---

### Block 391

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (11, 2, N'.xls', 0, 1, 1, 0, 1)
```

---

### Block 392

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (12, 2, N'.xlsx', 0, 1, 1, 0, 1)
```

---

### Block 393

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (13, 2, N'.xlsm', 0, 1, 1, 0, 1)
```

---

### Block 394

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (14, 2, N'PASTA1', 1, 0, 0, 0, 1)
```

---

### Block 395

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (15, 3, N'Microsoft PowerPoint - ', 1, 0, 1, 0, 1)
```

---

### Block 396

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (16, 3, N'PowerPoint - ', 1, 0, 1, 0, 1)
```

---

### Block 397

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (17, 3, N'.pps', 0, 1, 1, 0, 1)
```

---

### Block 398

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (18, 3, N'.ppsx', 0, 1, 1, 0, 1)
```

---

### Block 399

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (19, 3, N'.ppsm', 0, 1, 1, 0, 1)
```

---

### Block 400

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (20, 3, N'.ppt', 0, 1, 1, 0, 1)
```

---

### Block 401

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (21, 3, N'.pptx', 0, 1, 1, 0, 1)
```

---

### Block 402

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (22, 3, N'.pptm', 0, 1, 1, 0, 1)
```

---

### Block 403

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (23, 4, N'http://', 1, 0, 1, 0, 1)
```

---

### Block 404

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (24, 4, N'https://', 1, 0, 1, 0, 1)
```

---

### Block 405

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (25, 4, N'.htm', 0, 1, 1, 0, 1)
```

---

### Block 406

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (26, 4, N'.html', 0, 1, 1, 0, 1)
```

---

### Block 407

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (27, 4, N'.gif', 0, 1, 1, 0, 1)
```

---

### Block 408

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (28, 4, N'.jpg', 0, 1, 1, 0, 1)
```

---

### Block 409

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (29, 4, N'.jpeg', 0, 1, 1, 0, 1)
```

---

### Block 410

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (30, 4, N'.png', 0, 1, 1, 0, 1)
```

---

### Block 411

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (31, 5, N'Microsoft Paint - ', 1, 0, 1, 0, 1)
```

---

### Block 412

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (32, 5, N'Paint - ', 1, 0, 1, 0, 1)
```

---

### Block 413

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (33, 5, N'.bmp', 0, 1, 1, 0, 1)
```

---

### Block 414

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (34, 6, N'.eml', 0, 1, 1, 0, 1)
```

---

### Block 415

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (35, 6, N'Microsoft Office Outlook - ', 1, 0, 1, 0, 1)
```

---

### Block 416

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (36, 6, N're:', 1, 0, 0, 0, 1)
```

---

### Block 417

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (37, 6, N'Estilo Memorando', 1, 0, 1, 0, 1)
```

---

### Block 418

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (38, 6, N'outbind://', 1, 0, 1, 0, 1)
```

---

### Block 419

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (39, 7, N'Bloco de Notas - ', 1, 0, 1, 0, 1)
```

---

### Block 420

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (40, 7, N'.txt', 0, 1, 1, 0, 1)
```

---

### Block 421

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (41, 7, N'- Notepad', 0, 1, 1, 0, 1)
```

---

### Block 422

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (42, 7, N' - Bloco de notas', 0, 1, 1, 0, 1)
```

---

### Block 423

```sql
INSERT [dbo].[PrintApplicationsRules] ([PrintApplicationRuleID], [PrintApplicationID], [FindString], [BeginNameFind], [EndNameFind], [FoundStringRemove], [Hits], [RuleType]) VALUES (44, 8, N'.pdf', 0, 1, 1, 0, 1)
```

---

### Block 424

```sql
SET IDENTITY_INSERT [dbo].[PrintApplicationsRules] OFF
```

---

### Block 425

```sql
SET IDENTITY_INSERT [dbo].[GridColumns] ON
```

---

### Block 426

```sql
INSERT [dbo].[GridColumns] ([GridColumnsID], [AccountID], [PartnerEmail], [PartnerName], [GridID], [Columns], [IsDefault]) VALUES (1, NULL, NULL, NULL, N'user-list-grid', N'[{{""Field"":""permissionTypeText"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""fullName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""logonName"",""IsSelected"":true,""Unalterable"":true}},{{""Field"":""email"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""domainName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""accountName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""pinCode"",""IsSelected"":true,""Unalterable"":false}}]', 1)
```

---

### Block 427

```sql
INSERT [dbo].[GridColumns] ([GridColumnsID], [AccountID], [PartnerEmail], [PartnerName], [GridID], [Columns], [IsDefault]) VALUES (2, NULL, NULL, NULL, N'printer-list-grid', N'[{{""Field"":""isLocalText"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""printerName"",""IsSelected"":true,""Unalterable"":true}},{{""Field"":""addressName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""addressPort"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""serialNumber"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""brandName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""modelName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""siteName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""departmentName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""location"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""printerGroupName"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""enabledAccountingText"",""IsSelected"":true,""Unalterable"":false}},{{""Field"":""isConsolidatedText"",""IsSelected"":true,""Unalterable"":false}}]', 1)
```

---

### Block 428

```sql
SET IDENTITY_INSERT [dbo].[GridColumns] OFF
```

---

### Block 429

```sql
SET IDENTITY_INSERT [dbo].[AccountsViewSettings] ON
```

---

### Block 430

```sql
INSERT [dbo].[AccountsViewSettings] ([AccountViewSettingsID], [AccountID], [DashboardAsHomepage]) VALUES (1, NULL, 1)
```

---

### Block 431

```sql
SET IDENTITY_INSERT [dbo].[AccountsViewSettings] OFF
```

---

### Block 432

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (1, N'360AUserLogin', N'Usuário autenticado')
```

---

### Block 433

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (2, N'360ADealerLogin', N'Provedor autenticado')
```

---

### Block 434

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (3, N'360AUserPasswordChanged', N'Senha do usuário alterada')
```

---

### Block 435

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (4, N'360AUserPinChanged', N'Código PIN do usuário alterado')
```

---

### Block 436

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (5, N'360AUserSecPinChanged', N'Código PIN Seguro do usuário alterado')
```

---

### Block 437

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (6, N'360AUserSecPinChangedWithEmail', N'Código PIN Seguro do usuário alterado com envio de e-mail')
```

---

### Block 438

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (7, N'360AUserSecPinDisabled', N'Código PIN Seguro desativado')
```

---

### Block 439

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (8, N'360AUserCardCodeAdded', N'Código de cartão do usuário adicionado')
```

---

### Block 440

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (9, N'360AUserCardCodeExcluded', N'Código de cartão do usuário excluído')
```

---

### Block 441

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (10, N'360APinGenForAllDomainUsers', N'PIN gerado para todos os usuários do domínio')
```

---

### Block 442

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (11, N'360APinGenWithEmailForAllDomainUsers', N'PIN gerado com envio de e-mail para todos os usuários do domínio')
```

---

### Block 443

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (12, N'360APinGenForDomainUsersWithoutPin', N'PIN gerado somente para os usuários do domínio que não possuem PIN cadastrado')
```

---

### Block 444

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (13, N'360APinGenWithEmailForDomainUsersWithoutPin', N'PIN gerado com envio de e-mail somente para os usuários do domínio que não possuem PIN cadastrado')
```

---

### Block 445

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (14, N'360ASecPinGenForDomainUsersWithoutSecPin', N'PIN Seguro gerado somente para os usuários do domínio que não possuem PIN Seguro cadastrado')
```

---

### Block 446

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (15, N'360ASecPinGenWithEmailForDomainUsersWithoutSecPin', N'PIN Seguro gerado com envio de e-mail somente para os usuários do domínio que não possuem PIN Seguro cadastrado')
```

---

### Block 447

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (16, N'360ASecPinGenForAllDomainUsers', N'PIN Seguro gerado para todos os usuários do domínio')
```

---

### Block 448

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (17, N'360ASecPinGenWithEmailForAllDomainUsers', N'PIN Seguro gerado com envio de e-mail para todos os usuários do domínio')
```

---

### Block 449

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (18, N'360ADomainUsersPasswordsRequest', N'Senhas solicitadas para os usuários do domínio')
```

---

### Block 450

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (19, N'360AGroupUsersPasswordsRequest', N'Senhas solicitadas para os usuários do grupo')
```

---

### Block 451

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (20, N'360APinGenForAllGroupUsers', N'PIN gerado para todos os usuários do grupo')
```

---

### Block 452

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (21, N'360APinGenWithEmailForAllGroupUsers', N'PIN gerado com envio de e-mail para todos os usuários do grupo')
```

---

### Block 453

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (22, N'360ASecPinGenForAllGroupUsers', N'PIN Seguro gerado para todos os usuários do grupo')
```

---

### Block 454

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (23, N'360ASecPinGenWithEmailForAllGroupUsers', N'PIN Seguro gerado com envio de e-mail para todos os usuários do grupo')
```

---

### Block 455

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (24, N'360APinGenForGroupUsersWithoutPin', N'PIN gerado somente para os usuários do grupo que não possuem PIN cadastrado')
```

---

### Block 456

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (25, N'360APinGenWithEmailForGroupUsersWithoutPin', N'PIN gerado com envio de e-mail somente para os usuários do grupo que não possuem PIN cadastrado')
```

---

### Block 457

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (26, N'360ASecPinGenForGroupUsersWithoutSecPin', N'PIN Seguro gerado somente para os usuários do grupo que não possuem PIN Seguro cadastrado')
```

---

### Block 458

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (27, N'360ASecPinGenWithEmailForGroupUsersWithoutSecPin', N'PIN Seguro gerado com envio de e-mail somente para os usuários do grupo que não possuem PIN Seguro cadastrado')
```

---

### Block 459

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (28, N'360ASettGeneralPinSecPinEmail', N'Configurações gerais alterada: E-mail de PIN e PIN Seguro')
```

---

### Block 460

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (29, N'360ASettGeneralReportEmail', N'Configurações gerais alterada: E-mail de relatórios')
```

---

### Block 461

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (30, N'360ASettGeneralPasswordRequestEmail', N'Configurações gerais alterada: E-mail solicitar senhas')
```

---

### Block 462

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (31, N'360ASettUsersCardCodeQuantity', N'Configurações de usuários alterada: Quantidade de código de cartões dos usuários')
```

---

### Block 463

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (32, N'360AManagerQuotaPermissionChanged', N'Administração de cotas do gerente alterada')
```

---

### Block 464

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (33, N'360AUserQuotaControlDisabled', N'Controle de cotas do usuário desativado')
```

---

### Block 465

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (34, N'360AUserQuotaControlEnabled', N'Controle de cotas do usuário ativado')
```

---

### Block 466

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (35, N'360AUserCorporateQuotaAdded', N'Cota corporativa adicionada para o usuário')
```

---

### Block 467

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (36, N'360AUserParticularQuotaAdded', N'Cota particular adicionada para o usuário')
```

---

### Block 468

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (37, N'360AUserCorporateQuotaRuleAdded', N'Regra de cota corporativa adicionada para o usuário')
```

---

### Block 469

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (38, N'360AUserParticularQuotaRuleAdded', N'Regra de cota particular adicionada para o usuário')
```

---

### Block 470

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (39, N'360AUserQuotaExcluded', N'Cota excluída do usuário')
```

---

### Block 471

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (40, N'360AUserQuotaRuleExcluded', N'Regra de cota excluída do usuário')
```

---

### Block 472

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (41, N'360AUserGroupCorporateQuotaAdded', N'Cota corporativa adicionada para o grupo de usuário')
```

---

### Block 473

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (42, N'360AUserGroupParticularQuotaAdded', N'Cota particular adicionada para o grupo de usuário')
```

---

### Block 474

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (43, N'360AUserGroupCorporateQuotaRuleAdded', N'Regra de cota corporativa adicionada para o grupo de usuário')
```

---

### Block 475

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (44, N'360AUserGroupParticularQuotaRuleAdded', N'Regra de cota particular adicionada para o grupo de usuário')
```

---

### Block 476

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (45, N'360AUserGroupQuotaExcluded', N'Cota excluída do grupo de usuário')
```

---

### Block 477

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (46, N'360AUserGroupQuotaRuleExcluded', N'Regra de cotas excluída do grupo de usuário')
```

---

### Block 478

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (47, N'360ASettJobAssignmentFinalityDisplayName', N'Configurações de atribuição de trabalhos alterada: Termo de exibição ""finalidade""')
```

---

### Block 479

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (48, N'360ASettJobAssignmentCorporativeDisplayName', N'Configurações de atribuição de trabalhos alterada: Termo de exibição ""corporativa""')
```

---

### Block 480

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (49, N'360ASettUsersManagerQuotaPermissionChanged', N'Configurações de usuários alterada: Administração de cotas pelos gerentes')
```

---

### Block 481

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (50, N'360ASettQuotasBehavior', N'Configurações de cotas alterada: Ativação e comportamento')
```

---

### Block 482

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (51, N'360ASettQuotasType', N'Configurações de cotas alterada: Tipo de cota')
```

---

### Block 483

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (52, N'360ASettQuotasUnit', N'Configurações de cotas alterada: Unidade de controle das cotas')
```

---

### Block 484

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (53, N'360ASettQuotasDefaultRule', N'Configurações de cotas alterada: Regra padrão de cotas')
```

---

### Block 485

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (54, N'360ASettQuotasAlertResponsible', N'Configurações de cotas alterada: Aviso de cotas para o responsável')
```

---

### Block 486

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (55, N'360ASettQuotasAlertManagers', N'Configurações de cotas alterada: Aviso de cotas para os gerentes')
```

---

### Block 487

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (56, N'360ASettQuotasAlertUsers', N'Configurações de cotas alterada: Aviso de cotas para os usuários')
```

---

### Block 488

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (57, N'360ASettQuotasAlertEndedMsg', N'Configurações de cotas alterada: Mensagem de alerta aos usuários quando cotas acabarem')
```

---

### Block 489

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (58, N'360ASettQuotasAlertEnding', N'Configurações de cotas alterada: Alerta para os usuários de cotas acabando')
```

---

### Block 490

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (59, N'360ASettQuotasCopiesDiscount', N'Configurações de cotas alterada: Desconto de cópias')
```

---

### Block 491

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (60, N'360ASettQuotasIdentifyCode', N'Configurações de cotas alterada: Identificação das cotas')
```

---

### Block 492

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (61, N'360AUserRemovedAccount', N'Usuário removido da conta')
```

---

### Block 493

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (62, N'360AUserAddAccount', N'Usuário adicionado na conta')
```

---

### Block 494

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (63, N'360AUserHistoryAccountsChanged', N'Histórico de contas do usuário alterado')
```

---

### Block 495

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (64, N'360AUserAddedAsAccountManager', N'Usuário adicionado como gerente da conta')
```

---

### Block 496

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (65, N'360AManagerRemovedFromAccount', N'Gerente removido da conta')
```

---

### Block 497

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (66, N'360APrinterRemovedFromAccount', N'Impressora removida da conta')
```

---

### Block 498

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (67, N'360APrinterAddedToAccount', N'Impressora adicionada na conta')
```

---

### Block 499

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (68, N'360APrinterAccountsHistoryChanged', N'Histórico de contas da impressora alterado')
```

---

### Block 500

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (69, N'360ACreatedAccount', N'Conta criada')
```

---

### Block 501

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (70, N'360ADeletedAccount', N'Conta excluída')
```

---

### Block 502

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (71, N'360AAccountMovedToRoot', N'Conta movida para a raiz')
```

---

### Block 503

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (72, N'360AAccountMovedToAccount', N'Conta movida para a conta')
```

---

### Block 504

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (73, N'360AAccountPropChanged', N'Nome da conta alterado')
```

---

### Block 505

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (74, N'360AAccountMovedToRootWCodeChanged', N'Conta movida para a raiz, com alteração do código')
```

---

### Block 506

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (75, N'360AChangedAccountAttribution', N'Atribuição da conta alterada')
```

---

### Block 507

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (76, N'360ASettJobAssignChangedTypeOfObject', N'Configurações de atribuição de trabalhos alterada: Tipo de objeto a controlar')
```

---

### Block 508

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (77, N'360ASettJobAssignChangedSelectedAcconts', N'Configurações de atribuição de trabalhos alterada: Seleção de contas')
```

---

### Block 509

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (78, N'360ASettJobAssignChangedViewAccountCodeReports', N'Configurações de atribuição de trabalhos alterada: Exibir código da conta nos relatórios')
```

---

### Block 510

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (79, N'360ASettJobAssignChangedPrintPurpose', N'Configurações de atribuição de trabalhos alterada: Finalidade de impressão')
```

---

### Block 511

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (80, N'360ASettJobAssignChangedTermDisplayAccount', N'Configurações de atribuição de trabalhos alterada: Termo de exibição ""conta""')
```

---

### Block 512

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (81, N'360AAccountMovedToAccountWCodeChanged', N'Conta movida para a conta, com alteração do código')
```

---

### Block 513

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (82, N'360AManagerPolicyManagerChange', N'Administração de políticas do gerente alterada')
```

---

### Block 514

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (83, N'360AMemberAddedPolicy', N'Membro adicionado à política')
```

---

### Block 515

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (84, N'360AMemberRemovedPolicy', N'Membro removido da política')
```

---

### Block 516

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (85, N'360AAllMembersAddedPolicy', N'Todos os membros adicionados na política')
```

---

### Block 517

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (86, N'360AAllMembersRemovedPolicy', N'Todos os membros removidos da política')
```

---

### Block 518

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (87, N'360APrinterPolicyCreatedBehaviorPermissionAllow', N'Política de impressão criada com o comportamento: Permissão - Permitir')
```

---

### Block 519

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (88, N'360APrinterPolicyCreatedBehaviorPermissionConfirmation', N'Política de impressão criada com o comportamento: Permissão - Confirmar estação')
```

---

### Block 520

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (89, N'360APrinterPolicyCreatedBehaviorPermissionAlert', N'Política de impressão criada com o comportamento: Permissão - Alertar')
```

---

### Block 521

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (90, N'360APrinterPolicyCreatedBehaviorPermissionDeny', N'Política de impressão criada com o comportamento: Permissão - Não permitir')
```

---

### Block 522

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (91, N'360APrinterPolicyCreatedBehaviorSecurityPrint', N'Política de impressão criada com o comportamento: Segurança - Imprimir')
```

---

### Block 523

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (92, N'360APrinterPolicyCreatedBehaviorSecurityDontPrint', N'Política de impressão criada com o comportamento: Segurança - Não imprimir')
```

---

### Block 524

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (93, N'360APrinterPolicyCreatedBehaviorConversionMono', N'Política de impressão criada com o comportamento: Conversão - Monocromático')
```

---

### Block 525

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (94, N'360APrinterPolicyCreatedBehaviorConversionDuplex', N'Política de impressão criada com o comportamento: Conversão - Duplex')
```

---

### Block 526

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (95, N'360ACopyPolicyCreatedBehaviorAllow', N'Política de cópia criada com o comportamento: Permissão - Permitir')
```

---

### Block 527

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (96, N'360ACopyPolicyCreatedBehaviorDeny', N'Política de cópia criada com o comportamento:  Permissão - Não Permitir')
```

---

### Block 528

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (97, N'360AFaxPolicyCreatedBehaviorAllow', N'Política de envio de fax criada com o comportamento:  Permissão - Permitir')
```

---

### Block 529

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (98, N'360AFaxPolicyCreatedBehaviorDeny', N'Política de envio de fax criada com o comportamento:  Permissão - Não Permitir')
```

---

### Block 530

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (99, N'360AScanPolicyCreatedBehaviorAllow', N'Política de digitalização criada com o comportamento:  Permissão - Permitir')
```

---

### Block 531

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (100, N'360AScanPolicyCreatedBehaviorDeny', N'Política de digitalização criada com o comportamento:  Permissão - Não Permitir')
```

---

### Block 532

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (101, N'360APolicyDeleted', N'Política excluída')
```

---

### Block 533

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (102, N'360APolicyDisabled', N'Política desabilitada')
```

---

### Block 534

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (103, N'360APolicyChangedProp', N'Propriedades da política alteradas')
```

---

### Block 535

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (104, N'360APolicyChangedType', N'Tipo da política alterado')
```

---

### Block 536

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (105, N'360APolicyEnabled', N'Política habilitada')
```

---

### Block 537

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (106, N'360ASettPolicyManager', N'Configurações de usuários alterada: Administração de políticas pelos gerentes alterada')
```

---

### Block 538

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (107, N'360ASettPolicyPrintMark', N'Configurações de políticas alterada: Marcas de impressão')
```

---

### Block 539

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (108, N'360ADomainMergedWithDomain', N'Domínio unificado com o domínio')
```

---

### Block 540

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (109, N'360AUserAddedAlias', N'Vinculo adicionado para o usuário')
```

---

### Block 541

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (110, N'360AUserDefaultAlias', N'Usuário principal do vínculo definido')
```

---

### Block 542

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (111, N'360AUserDeletedAlias', N'Vinculo removido do usuário')
```

---

### Block 543

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (112, N'360AUserDiskSpaceChanged', N'Espaço em disco da liberação segura do usuário alterado')
```

---

### Block 544

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (113, N'360AUserGroupUserAdded', N'Usuário adicionado no grupo')
```

---

### Block 545

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (114, N'360AUserGroupUserDeleted', N'Usuário removido do grupo')
```

---

### Block 546

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (115, N'360APrinterAccDisabled', N'Contabilização da impressora desativada')
```

---

### Block 547

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (116, N'360APrinterAccEnabled', N'Contabilização da impressora ativada')
```

---

### Block 548

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (117, N'360APrinterAccOriginChanged', N'Origem da contabilização da impressora alterada')
```

---

### Block 549

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (118, N'360APrinterAccGroupChanged', N'Grupo da impressora alterado para')
```

---

### Block 550

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (119, N'360APrinterAccFColorChanged', N'Forçar cor alterado')
```

---

### Block 551

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (120, N'360APrinterConsolidationAdded', N'Impressora consolidada à impressora')
```

---

### Block 552

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (121, N'360APrinterConsolidationRemoved', N'Consolidação removida da impressora')
```

---

### Block 553

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (122, N'360AComputersInactiveDeleted', N'Computador inativo excluído')
```

---

### Block 554

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (123, N'360AComputerDeleted', N'Computador excluído')
```

---

### Block 555

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (124, N'360AComputerInstProdDeleted', N'Produto instalado excluído')
```

---

### Block 556

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (125, N'360APrinterGroupCostChanged', N'Custo do grupo de impressora alterado')
```

---

### Block 557

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (126, N'360APrinterGroupPaperTypeCostChanged', N'Custo do tipo de papel do grupo de impressora alterado')
```

---

### Block 558

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (127, N'360APrinterGroupPrinterAdded', N'Impressora adicionada no grupo')
```

---

### Block 559

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (128, N'360APrinterGroupPrinterRemoved', N'Impressora removida do grupo')
```

---

### Block 560

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (129, N'360ASettSecReleaseDSpaceChanged', N'Configurações de liberação segura alterada: Limitação de espaço em disco no nddPrint Releaser')
```

---

### Block 561

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (130, N'360ASettAccPrintAppCreated', N'Aplicativo de impressão criado')
```

---

### Block 562

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (131, N'360ASettAccPrintAppChanged', N'Aplicativo de impressão alterado')
```

---

### Block 563

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (132, N'360ASettAccPrintAppDeleted', N'Aplicativo de impressão excluído')
```

---

### Block 564

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (133, N'360ASettAccPrintQualityChanged', N'Configurações de contabilização alterada: Qualidade de impressão no modo rascunho')
```

---

### Block 565

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (134, N'360ASettAccIgnoreAccChanged', N'Configurações de contabilização alterada: Ignorar a contabilização dos trabalhos de impressão')
```

---

### Block 566

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (135, N'360ASettAccAgentGeneralChanged', N'Configurações de contabilização alterada: Configurações gerais do nddPrint Agent')
```

---

### Block 567

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (136, N'360ASettAccAgentAccRulesChanged', N'Configurações de contabilização alterada: Regras de contabilização do nddPrint Agent')
```

---

### Block 568

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (137, N'360ASettAccAgentSearchSnmpChanged', N'Configurações de contabilização alterada: Busca de informações das impressoras por SNMP do nddPrint Agent')
```

---

### Block 569

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (138, N'360ASettAccAgentOffModeChanged', N'Configurações de contabilização alterada: Modo offline do nddPrint Agent')
```

---

### Block 570

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (139, N'360ASettAccAgentPrintersAccChanged', N'Configurações de contabilização alterada: Contabilização de impressoras do nddPrint Agent')
```

---

### Block 571

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (140, N'360ASettAccAgentAccErpChanged', N'Configurações de contabilização alterada: Contabilização diferenciada ERP do nddPrint Agent')
```

---

### Block 572

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (141, N'360ASettAccAgentUserAuthChanged', N'Configurações de contabilização alterada: Autenticação de usuários ao imprimir do nddPrint Agent')
```

---

### Block 573

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (142, N'360ASettAccAgentUserMemSessionChanged', N'Configurações de contabilização alterada: Sessão de memória do usuário do nddPrint Agent')
```

---

### Block 574

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (143, N'360ASettPrintersAccSourceChanged', N'Configurações de impressoras alterada: Origem da contabilização padrão')
```

---

### Block 575

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (144, N'360ASettPrintersDisableRulesChanged', N'Configurações de impressoras alterada: Regra para desabilitar impressoras automaticamente')
```

---

### Block 576

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (145, N'360ASettPrintersAssignRulesChanged', N'Configurações de impressoras alterada: Regra para atribuir impressoras aos grupos automaticamente')
```

---

### Block 577

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (146, N'360ASettPrintersSessionChanged', N'Configurações de impressoras alterada: Sessão das impressoras')
```

---

### Block 578

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (147, N'360ASettMpsUsbCountersChanged', N'Configurações do nddPrint MPS alterada: Captura dos contadores de impressoras USB')
```

---

### Block 579

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (148, N'360AUserCreated', N'Usuário criado')
```

---

### Block 580

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (149, N'360AUserDeleted', N'Usuário excluído')
```

---

### Block 581

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (150, N'360AUserRegisterChanged', N'Dados cadastrais do usuário alterado')
```

---

### Block 582

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (151, N'360AUserReportsPermissionChanged', N'Permissão do usuário para relatórios alterada')
```

---

### Block 583

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (152, N'360AUserProfilePermissionChanged', N'Alteração no perfil do usuário')
```

---

### Block 584

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (153, N'360ADomainDeleted', N'Domínio excluído')
```

---

### Block 585

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (154, N'360AUserGroupCreated', N'Grupo de usuários criado')
```

---

### Block 586

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (155, N'360AUserGroupDeleted', N'Grupo de usuários excluído')
```

---

### Block 587

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (156, N'360AUserGroupNameChanged', N'Nome do grupo de usuários alterado')
```

---

### Block 588

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (157, N'360APrinterGroupDefaultDefined', N'Grupo de impressoras padrão definido')
```

---

### Block 589

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (158, N'360APrinterGroupCreated', N'Grupo de impressoras criado')
```

---

### Block 590

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (159, N'360APrinterGroupDeleted', N'Grupo de impressoras excluído')
```

---

### Block 591

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (160, N'360APrinterGroupNameChanged', N'Nome do grupo de impressoras alterado')
```

---

### Block 592

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (161, N'360ASettGenOfficeHoursChanged', N'Configurações gerais alterada: Horário do experiente')
```

---

### Block 593

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (162, N'360ASettGenInstProdExpChanged', N'Configurações gerais alterada: Expiração de produtos instalados')
```

---

### Block 594

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (163, N'360ASettGenCostOptChanged', N'Configurações gerais alterada: Opções de custo')
```

---

### Block 595

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (164, N'360ASettUsersLocDomainNameChanged', N'Configurações de domínios alterada: Nome do domínio de usuários locais')
```

---

### Block 596

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (165, N'360ASettMySettLangRegChanged', N'Idioma e informações regionais alterado')
```

---

### Block 597

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (166, N'360ASiteDeleted', N'Local excluído')
```

---

### Block 598

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (167, N'360ASubNetworkRemoved', N'Sub-rede excluída')
```

---

### Block 599

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (168, N'360ASubNetworkCreated', N'Sub-rede criada')
```

---

### Block 600

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (169, N'360ASubNetworkAddedd', N'Sub-rede adicionada')
```

---

### Block 601

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (170, N'360ASiteCreated', N'Local criado')
```

---

### Block 602

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (171, N'360ASiteDefaultDefined', N'Local padrão definido')
```

---

### Block 603

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (172, N'360ASettGeneralLicAlertsChanged', N'Configurações gerais alterada: Alertas de licenciamento')
```

---

### Block 604

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (173, N'360ADepartmentDeleted', N'Departamento excluído do local')
```

---

### Block 605

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (174, N'360ADepartmentCreated', N'Departamento criado no local')
```

---

### Block 606

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (175, N'360ADepartmentUpdated', N'Departamento alterado no local')
```

---

### Block 607

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (176, N'360ASiteChanged', N'Local alterado')
```

---

### Block 608

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (177, N'360APrinterRemovedFromDepartment', N'Impressora removida do departamento')
```

---

### Block 609

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (178, N'360APrinterAddedToDepartment', N'Impressora adicionada ao departamento')
```

---

### Block 610

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (179, N'360ASettQuotasPrepaid', N'Configurações de cotas alterada: Cartões pré-pagos')
```

---

### Block 611

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (180, N'360AQuotasPrepaidCodesGenerated', N'Códigos de cartões pré-pagos gerados')
```

---

### Block 612

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (181, N'360APrepaidCardCodesExported', N'Cartões pré-pagos exportados')
```

---

### Block 613

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (182, N'360AQuotasPrepaidCorporativeCreditAdd', N'Cota pré-paga corporativa adicionada para o usuário')
```

---

### Block 614

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (183, N'360AQuotasPrepaidParticularCreditAdd', N'Cota pré-paga particular adicionada para o usuário')
```

---

### Block 615

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (184, N'360APrinterQuotaExcluded', N'Cota da impressora excluída')
```

---

### Block 616

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (185, N'360APrinterQuotaRuleExcluded', N'Regra de cota da impressora excluída')
```

---

### Block 617

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (186, N'360APrinterQuotaControlDisabled', N'Controle de cotas da impressora desativado')
```

---

### Block 618

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (187, N'360APrinterQuotaControlEnabled', N'Controle de cotas da impressora ativado')
```

---

### Block 619

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (188, N'360APrinterQuotaCreditAdded', N'Cota adicionada para a impressora')
```

---

### Block 620

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (189, N'360APrinterQuotaRuleAdded', N'Regra de cota adicionada para a impressora')
```

---

### Block 621

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (190, N'360APrinterGroupQuotaAdded', N'Cota adicionada para o grupo de impressora')
```

---

### Block 622

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (192, N'360APrinterGroupQuotaRuleAdded', N'Regra de cota adicionada para o grupo de impressora')
```

---

### Block 623

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (193, N'360APrinterGroupQuotaRuleExcluded', N'Regra de cota excluída do grupo de impressoras')
```

---

### Block 624

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (194, N'360APrinterGroupQuotaExcluded', N'Cota excluída do grupo de impressoras')
```

---

### Block 625

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (195, N'360ASettQuotasAlertPercentageManager', N'Configurações de cotas alterada: Aviso de cotas por porcentagem para os gerentes')
```

---

### Block 626

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (196, N'360ASettQuotasAlertPercentageUsers', N'Configurações de cotas alterada: Aviso de cotas por porcentagem para os usuários')
```

---

### Block 627

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (197, N'360ASettQuotasAlertPercentageResponsible', N'Configurações de cotas alterada: Aviso de cotas por porcentagem para os responsáveis')
```

---

### Block 628

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (198, N'360ASettingsUserChangePin', N'Alteração de PIN pelos usuários')
```

---

### Block 629

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (199, N'360ANotificationMarkAsRead', N'Notificação marcada como lida')
```

---

### Block 630

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (200, N'360ANotificationMarkAsRemoved', N'Notificação removida')
```

---

### Block 631

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (201, N'360ANotificationDownload', N'Download realizado')
```

---

### Block 632

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (202, N'360AExportGridDomain', N'Exportação da lista de domínios solicitada')
```

---

### Block 633

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (203, N'360AExportGridMachine', N'Exportação da lista de computadores solicitada')
```

---

### Block 634

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (204, N'360AExportGridPolicy', N'Exportação da lista de políticas solicitada')
```

---

### Block 635

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (205, N'360AExportGridPrinter', N'Exportação da lista de impressoras solicitada')
```

---

### Block 636

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (206, N'360AExportGridCostGroup', N'Exportação da lista de custos de impressoras solicitada')
```

---

### Block 637

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (207, N'360AExportGridMachineQueues', N'Exportação da lista de filas de impressão do computador solicitada')
```

---

### Block 638

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (208, N'360AExportGridUser', N'Exportação da lista de usuários solicitada')
```

---

### Block 639

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (209, N'360AExportGridUserGroup', N'Exportação da lista de grupos de usuários solicitada')
```

---

### Block 640

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (210, N'360AExportPrinterReport', N'Exportação das impressoras com data da última contabilização solicitada')
```

---

### Block 641

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (211, N'360AExportCardCodesReport', N'Exportação de códigos de cartões solicitada')
```

---

### Block 642

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (212, N'360ASettMySettViewSettChanged', N'Visão inicial alterada')
```

---

### Block 643

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (213, N'360ASettViewSettChanged', N'Configurações gerais alterada: Definir visão inicial')
```

---

### Block 644

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (214, N'360ASettingsQuotasPaymentsChanged', N'Configurações de cotas alteradas: Compra de créditos')
```

---

### Block 645

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (215, N'360ACreditBought', N'Compra de crédito solicitada')
```

---

### Block 646

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (216, N'360APrinterRemoved', N'Exclusão de impressora')
```

---

### Block 647

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (217, N'360APinGenForUserWithEmail', N'Código PIN do usuário alterado com envio de e-mail')
```

---

### Block 648

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (218, N'360AScanFlowGroupCreated', N'Grupo de fluxos de digitalização criado')
```

---

### Block 649

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (219, N'360AScanFlowGroupNameChanged', N'Nome do grupo de fluxos de digitalização alterado')
```

---

### Block 650

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (220, N'360AScanFlowChanged', N'Configuração de fluxos de digitalização alterada: Ativação')
```

---

### Block 651

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (221, N'360AScanFlowCreated', N'Fluxo de digitalização criado')
```

---

### Block 652

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (222, N'360AAllMembersAddedScanFlow', N'Todos os membros adicionados no fluxo de digitalização')
```

---

### Block 653

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (223, N'360AAllMembersRemovedScanFlow', N'Todos os membros removidos do fluxo de digitalização')
```

---

### Block 654

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (224, N'360AMemberAddedScanFlow', N'Membro adicionado ao fluxo de digitalização:')
```

---

### Block 655

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (225, N'360AMemberRemovedScanFlow', N'Membro removido do fluxo de digitalização:')
```

---

### Block 656

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (226, N'360AScanFlowGroupDeleted', N'Grupo de fluxo de digitalização excluído')
```

---

### Block 657

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (227, N'360AScanFlowPropertiesChanged', N'Propriedades do fluxo de digitalização alteradas')
```

---

### Block 658

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (228, N'360AScanFlowDeleted', N'Fluxo de digitalização excluído')
```

---

### Block 659

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (229, N'360ASettingsDomainAccessAd', N'Configurações de acesso do domínio')
```

---

### Block 660

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (230, N'360ASettGeneralDefaultEmailLanguageChanged', N'Configurações gerais alterada: Idioma padrão de recebimento de e-mails')
```

---

### Block 661

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (231, N'360APrinterSiteChanged', N'Local da impressora alterado')
```

---

### Block 662

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (232, N'360ASettIntegration360BehaviorChanged', N'Configuração de Integração 360 alterada: Ativação')
```

---

### Block 663

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (233, N'360ASettIntegration360CreateKeys', N'Configuração de Integração 360 alterada: Chaves de acesso à API geradas')
```

---

### Block 664

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (234, N'360ASettIntegration360RevokeKeys', N'Configuração de Integração 360 alterada: Chaves de acesso à API revogadas')
```

---

### Block 665

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (235, N'360ADomainCreated', N'Domínio criado')
```

---

### Block 666

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (236, N'360ADomainConsolidatedRuleChanged', N'Configurações de domínios alterada: Regras de consolidação de domínios')
```

---

### Block 667

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (237, N'360ADefaultDomainDefined', N'Domínio padrão definido')
```

---

### Block 668

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (238, N'360ASettGeneralDpoChanged', N'Configurações gerais alterada: Data Protection Officer (DPO)')
```

---

### Block 669

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (239, N'360AMemberAddedAccountSelectable', N'Membro adicionado à conta selecionável')
```

---

### Block 670

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (240, N'360AMemberRemovedAccountSelectable', N'Membro removido da conta selecionável')
```

---

### Block 671

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (241, N'360AScanFlowFtpSettingsChanged', N'Configuração do Digital Shift alterada: FTP')
```

---

### Block 672

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (242, N'360ASettIntegrationPrintJobsBehaviorChanged', N'Configuração de Integração de trabalhos de impressão alterada: Ativação')
```

---

### Block 673

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (243, N'360ASettIntegrationPrintJobsCreateKeys', N'Configuração de Integração de trabalhos de impressão alterada: Chaves de acesso à API geradas')
```

---

### Block 674

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (244, N'360ASettIntegrationPrintJobsRevokeKeys', N'Configuração de Integração de trabalhos de impressão alterada: Chaves de acesso à API revogadas')
```

---

### Block 675

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (245, N'360AScanFlowSharePointSettingsChanged', N'Configuração do Digital Shift alterada: SharePoint Online (365)')
```

---

### Block 676

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (246, N'360AUserAnonymizationPeriodSettingsChanged', N'Configurações de usuários alterada: Período de armazenamento dos dados pessoais após a exclusão do usuário')
```

---

### Block 677

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (247, N'360ACustomReportCreated', N'Relatório personalizado criado')
```

---

### Block 678

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (248, N'360ACustomReportUpdated', N'Relatório personalizado alterado')
```

---

### Block 679

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (249, N'360ACustomReportDeleted', N'Relatório personalizado removido')
```

---

### Block 680

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (250, N'360PrinterCreated', N'Impressora Criada')
```

---

### Block 681

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (251, N'360PrintersAuthenticationUpdated', N'Configuração de autenticação nas impressoras atualizada')
```

---

### Block 682

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (252, N'360SecureReleaseUpdate', N'Configuração de liberação segura atualizada')
```

---

### Block 683

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (253, N'360DeviceUpdated', N'Cadastro de instalação atualizado')
```

---

### Block 684

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (254, N'360UserPinConfigUpdate', N'Configuração de geração de PIN atualizada')
```

---

### Block 685

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (255, N'360SnmpConnectionsUpdated', N'Configuração SNMP atualizada')
```

---

### Block 686

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (256, N'360WorkstationAuthenticationUpdated', N'Cadastro de instalação atualizado')
```

---

### Block 687

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (257, N'360PrinterCostsUpdated', N'Custos da impressora atualizados')
```

---

### Block 688

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (258, N'360DomainUpdated', N'Configuração de domínio de usuários locais atualizada')
```

---

### Block 689

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (259, N'360CostCreated', N'Custo criado')
```

---

### Block 690

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (260, N'360CostDeleted', N'Custo excluído')
```

---

### Block 691

```sql
INSERT [dbo].[AuditActions] ([AuditActionID], [AuditActionResource], [AuditActionDescription]) VALUES (261, N'360CostUpdated', N'Custo alterado')
```

---

### Block 692

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (1, N'User', N'Relatório de usuários')
```

---

### Block 693

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (2, N'Printer', N'Relatório de impressoras')
```

---

### Block 694

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (3, N'PrintSpool', N'Relatório de filas de impressão')
```

---

### Block 695

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (4, N'Computer', N'Relatório de computadores')
```

---

### Block 696

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (5, N'UsersWithCostCenter', N'Relatório de usuários com centro de custo')
```

---

### Block 697

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (6, N'UsersWithoutCostCenter', N'Relatório de usuários sem centro de custo')
```

---

### Block 698

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (7, N'CostCenter', N'Relatório de centros de custo')
```

---

### Block 699

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (8, N'Quotas', N'Relatório de cotas de usuário')
```

---

### Block 700

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (9, N'SupplyHistory', N'Inventário de suprimentos')
```

---

### Block 701

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (10, N'InstalledProducts', N'Produtos instalados')
```

---

### Block 702

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (11, N'PrinterInventory', N'Inventário de impressoras')
```

---

### Block 703

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (12, N'PrinterStatus', N'Relatório de impressoras em alerta')
```

---

### Block 704

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (13, N'SuppliesChange', N'Relatório de troca de suprimentos')
```

---

### Block 705

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (14, N'Project', N'Relatório de projetos')
```

---

### Block 706

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (15, N'PurchaseForecast', N'Previsão de compra de suprimentos')
```

---

### Block 707

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (16, N'CounterGeneral', N'Comparativo entre Contadores e Jobs')
```

---

### Block 708

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (17, N'CounterByPrinters', N'Relatório de contadores por impressora')
```

---

### Block 709

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (18, N'GeneralAnalysis', N'Análise geral')
```

---

### Block 710

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (19, N'GeneralCountersByPrinters', N'Relatório de contadores gerais por impressoras')
```

---

### Block 711

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (20, N'PrinterSupply', N'Relatório de suprimentos por impressora')
```

---

### Block 712

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (23, N'Digitalization', N'Relatório de digitalização')
```

---

### Block 713

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (24, N'PrintersWithoutCounters', N'Relatório de impressoras não monitoradas')
```

---

### Block 714

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (25, N'CountersByEngagedVolume', N'Relatório por volume contratado')
```

---

### Block 715

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (27, N'QuickUsersReport', N'Relatório rápido de usuários')
```

---

### Block 716

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (28, N'CountersInventory', N'Relatório de inventário de contadores')
```

---

### Block 717

```sql
INSERT [dbo].[Reports] ([ReportID], [ReportName], [ReportDescription]) VALUES (29, N'CostAccount', N'Relatório de contas')
```

---

### Block 718

```sql
SET IDENTITY_INSERT [dbo].[CostAccountsManagersPermissions] ON
```

---

### Block 719

```sql
INSERT [dbo].[CostAccountsManagersPermissions] ([AccountID], [QuotasPermissionType], [PoliciesPermissionType], [CostAccountsManagerPermissionID]) VALUES (NULL, 1, 1, 1)
```

---

### Block 720

```sql
SET IDENTITY_INSERT [dbo].[CostAccountsManagersPermissions] OFF
```

---

### Block 721

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (1, N'360Accesses')
```

---

### Block 722

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (2, N'360Register')
```

---

### Block 723

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (3, N'360Accounts')
```

---

### Block 724

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (4, N'360Quotas')
```

---

### Block 725

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (5, N'360Policies')
```

---

### Block 726

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (6, N'360Accounting')
```

---

### Block 727

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (7, N'360Authentication')
```

---

### Block 728

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (8, N'360Settings')
```

---

### Block 729

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (9, N'360Exports')
```

---

### Block 730

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (10, N'360ScanFlows')
```

---

### Block 731

```sql
INSERT [dbo].[AuditCategories] ([AuditCategoryID], [CategoryName]) VALUES (11, N'360ACustomReports')
```

---

### Block 732

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (1, 1)
```

---

### Block 733

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (2, 1)
```

---

### Block 734

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 2)
```

---

### Block 735

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 7)
```

---

### Block 736

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (4, 7)
```

---

### Block 737

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (5, 7)
```

---

### Block 738

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (6, 7)
```

---

### Block 739

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (7, 7)
```

---

### Block 740

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (8, 7)
```

---

### Block 741

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (9, 7)
```

---

### Block 742

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (10, 7)
```

---

### Block 743

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (11, 7)
```

---

### Block 744

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (12, 7)
```

---

### Block 745

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (13, 7)
```

---

### Block 746

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (14, 7)
```

---

### Block 747

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (15, 7)
```

---

### Block 748

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (16, 7)
```

---

### Block 749

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (17, 7)
```

---

### Block 750

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 2)
```

---

### Block 751

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 7)
```

---

### Block 752

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 2)
```

---

### Block 753

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 7)
```

---

### Block 754

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (20, 7)
```

---

### Block 755

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (21, 7)
```

---

### Block 756

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (22, 7)
```

---

### Block 757

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (23, 7)
```

---

### Block 758

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (24, 7)
```

---

### Block 759

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (25, 7)
```

---

### Block 760

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (26, 7)
```

---

### Block 761

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (27, 7)
```

---

### Block 762

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 2)
```

---

### Block 763

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (28, 8)
```

---

### Block 764

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 6)
```

---

### Block 765

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (29, 8)
```

---

### Block 766

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (232, 8)
```

---

### Block 767

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (30, 8)
```

---

### Block 768

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 7)
```

---

### Block 769

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 8)
```

---

### Block 770

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (32, 4)
```

---

### Block 771

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (33, 4)
```

---

### Block 772

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (34, 4)
```

---

### Block 773

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (35, 4)
```

---

### Block 774

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (36, 4)
```

---

### Block 775

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (37, 4)
```

---

### Block 776

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (38, 4)
```

---

### Block 777

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (39, 4)
```

---

### Block 778

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (40, 4)
```

---

### Block 779

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (41, 4)
```

---

### Block 780

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (42, 4)
```

---

### Block 781

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (43, 4)
```

---

### Block 782

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (44, 4)
```

---

### Block 783

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (45, 4)
```

---

### Block 784

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (46, 4)
```

---

### Block 785

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 3)
```

---

### Block 786

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 4)
```

---

### Block 787

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 6)
```

---

### Block 788

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 8)
```

---

### Block 789

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 3)
```

---

### Block 790

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 4)
```

---

### Block 791

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 6)
```

---

### Block 792

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 8)
```

---

### Block 793

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 4)
```

---

### Block 794

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 8)
```

---

### Block 795

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 4)
```

---

### Block 796

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 8)
```

---

### Block 797

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 4)
```

---

### Block 798

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 8)
```

---

### Block 799

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 4)
```

---

### Block 800

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 8)
```

---

### Block 801

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 4)
```

---

### Block 802

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 8)
```

---

### Block 803

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 4)
```

---

### Block 804

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 8)
```

---

### Block 805

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 4)
```

---

### Block 806

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 8)
```

---

### Block 807

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 4)
```

---

### Block 808

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 8)
```

---

### Block 809

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 4)
```

---

### Block 810

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 8)
```

---

### Block 811

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 4)
```

---

### Block 812

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 8)
```

---

### Block 813

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 4)
```

---

### Block 814

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 8)
```

---

### Block 815

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 4)
```

---

### Block 816

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 8)
```

---

### Block 817

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 3)
```

---

### Block 818

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 6)
```

---

### Block 819

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 3)
```

---

### Block 820

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 6)
```

---

### Block 821

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (63, 3)
```

---

### Block 822

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (64, 3)
```

---

### Block 823

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (65, 3)
```

---

### Block 824

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 3)
```

---

### Block 825

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 6)
```

---

### Block 826

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 6)
```

---

### Block 827

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 3)
```

---

### Block 828

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (68, 6)
```

---

### Block 829

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 3)
```

---

### Block 830

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 2)
```

---

### Block 831

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 3)
```

---

### Block 832

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 2)
```

---

### Block 833

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (71, 3)
```

---

### Block 834

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (72, 3)
```

---

### Block 835

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 3)
```

---

### Block 836

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 2)
```

---

### Block 837

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (74, 3)
```

---

### Block 838

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 3)
```

---

### Block 839

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 6)
```

---

### Block 840

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 3)
```

---

### Block 841

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 6)
```

---

### Block 842

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 8)
```

---

### Block 843

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 3)
```

---

### Block 844

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 6)
```

---

### Block 845

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 8)
```

---

### Block 846

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 3)
```

---

### Block 847

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 6)
```

---

### Block 848

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 8)
```

---

### Block 849

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 4)
```

---

### Block 850

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 5)
```

---

### Block 851

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 6)
```

---

### Block 852

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 8)
```

---

### Block 853

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 3)
```

---

### Block 854

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 6)
```

---

### Block 855

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 8)
```

---

### Block 856

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (81, 3)
```

---

### Block 857

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (82, 5)
```

---

### Block 858

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (83, 5)
```

---

### Block 859

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (84, 5)
```

---

### Block 860

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (85, 5)
```

---

### Block 861

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (86, 5)
```

---

### Block 862

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 2)
```

---

### Block 863

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 5)
```

---

### Block 864

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 2)
```

---

### Block 865

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 5)
```

---

### Block 866

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 2)
```

---

### Block 867

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 5)
```

---

### Block 868

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 2)
```

---

### Block 869

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 5)
```

---

### Block 870

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 2)
```

---

### Block 871

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 5)
```

---

### Block 872

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 2)
```

---

### Block 873

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 5)
```

---

### Block 874

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 2)
```

---

### Block 875

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 5)
```

---

### Block 876

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 2)
```

---

### Block 877

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 5)
```

---

### Block 878

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 2)
```

---

### Block 879

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 5)
```

---

### Block 880

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 2)
```

---

### Block 881

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 5)
```

---

### Block 882

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 2)
```

---

### Block 883

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 5)
```

---

### Block 884

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 2)
```

---

### Block 885

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 5)
```

---

### Block 886

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 2)
```

---

### Block 887

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 5)
```

---

### Block 888

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 2)
```

---

### Block 889

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 5)
```

---

### Block 890

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 2)
```

---

### Block 891

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 5)
```

---

### Block 892

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 2)
```

---

### Block 893

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 5)
```

---

### Block 894

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (103, 5)
```

---

### Block 895

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (104, 5)
```

---

### Block 896

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 2)
```

---

### Block 897

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 5)
```

---

### Block 898

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (106, 5)
```

---

### Block 899

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (107, 5)
```

---

### Block 900

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 2)
```

---

### Block 901

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 3)
```

---

### Block 902

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 4)
```

---

### Block 903

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 5)
```

---

### Block 904

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 6)
```

---

### Block 905

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 7)
```

---

### Block 906

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (109, 6)
```

---

### Block 907

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (110, 6)
```

---

### Block 908

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (111, 6)
```

---

### Block 909

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (112, 6)
```

---

### Block 910

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (113, 6)
```

---

### Block 911

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (114, 6)
```

---

### Block 912

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (115, 6)
```

---

### Block 913

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (116, 6)
```

---

### Block 914

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (117, 6)
```

---

### Block 915

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (118, 6)
```

---

### Block 916

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (119, 6)
```

---

### Block 917

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (120, 6)
```

---

### Block 918

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (121, 6)
```

---

### Block 919

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (122, 6)
```

---

### Block 920

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (123, 6)
```

---

### Block 921

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (124, 6)
```

---

### Block 922

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (125, 6)
```

---

### Block 923

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (126, 6)
```

---

### Block 924

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (127, 6)
```

---

### Block 925

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (128, 6)
```

---

### Block 926

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 6)
```

---

### Block 927

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 8)
```

---

### Block 928

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 6)
```

---

### Block 929

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 8)
```

---

### Block 930

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 6)
```

---

### Block 931

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 8)
```

---

### Block 932

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 6)
```

---

### Block 933

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 8)
```

---

### Block 934

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 6)
```

---

### Block 935

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 8)
```

---

### Block 936

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 6)
```

---

### Block 937

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 8)
```

---

### Block 938

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 6)
```

---

### Block 939

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 8)
```

---

### Block 940

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 6)
```

---

### Block 941

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 8)
```

---

### Block 942

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 6)
```

---

### Block 943

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 8)
```

---

### Block 944

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 6)
```

---

### Block 945

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 8)
```

---

### Block 946

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 6)
```

---

### Block 947

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 8)
```

---

### Block 948

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 6)
```

---

### Block 949

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 8)
```

---

### Block 950

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 6)
```

---

### Block 951

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 8)
```

---

### Block 952

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 6)
```

---

### Block 953

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 8)
```

---

### Block 954

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 6)
```

---

### Block 955

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 8)
```

---

### Block 956

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 6)
```

---

### Block 957

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 8)
```

---

### Block 958

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 6)
```

---

### Block 959

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 8)
```

---

### Block 960

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 6)
```

---

### Block 961

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 8)
```

---

### Block 962

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 6)
```

---

### Block 963

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 8)
```

---

### Block 964

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (148, 2)
```

---

### Block 965

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (149, 2)
```

---

### Block 966

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (150, 2)
```

---

### Block 967

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (151, 2)
```

---

### Block 968

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (152, 2)
```

---

### Block 969

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (153, 2)
```

---

### Block 970

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (154, 2)
```

---

### Block 971

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (155, 2)
```

---

### Block 972

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (156, 2)
```

---

### Block 973

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 2)
```

---

### Block 974

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 6)
```

---

### Block 975

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (158, 2)
```

---

### Block 976

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (159, 2)
```

---

### Block 977

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (160, 2)
```

---

### Block 978

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 2)
```

---

### Block 979

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 6)
```

---

### Block 980

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 8)
```

---

### Block 981

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 2)
```

---

### Block 982

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 6)
```

---

### Block 983

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 8)
```

---

### Block 984

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 2)
```

---

### Block 985

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 6)
```

---

### Block 986

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 8)
```

---

### Block 987

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 2)
```

---

### Block 988

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 6)
```

---

### Block 989

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 8)
```

---

### Block 990

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 2)
```

---

### Block 991

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 8)
```

---

### Block 992

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 2)
```

---

### Block 993

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 6)
```

---

### Block 994

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 2)
```

---

### Block 995

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 6)
```

---

### Block 996

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 2)
```

---

### Block 997

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 6)
```

---

### Block 998

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 2)
```

---

### Block 999

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 6)
```

---

### Block 1000

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 2)
```

---

### Block 1001

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 6)
```

---

### Block 1002

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (171, 6)
```

---

### Block 1003

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 2)
```

---

### Block 1004

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 8)
```

---

### Block 1005

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (173, 2)
```

---

### Block 1006

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (174, 2)
```

---

### Block 1007

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (175, 2)
```

---

### Block 1008

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 2)
```

---

### Block 1009

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 6)
```

---

### Block 1010

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (177, 2)
```

---

### Block 1011

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (178, 2)
```

---

### Block 1012

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (184, 4)
```

---

### Block 1013

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (185, 4)
```

---

### Block 1014

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (186, 4)
```

---

### Block 1015

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (187, 4)
```

---

### Block 1016

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (188, 4)
```

---

### Block 1017

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (189, 4)
```

---

### Block 1018

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (190, 4)
```

---

### Block 1019

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 2)
```

---

### Block 1020

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (192, 4)
```

---

### Block 1021

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (193, 4)
```

---

### Block 1022

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (194, 4)
```

---

### Block 1023

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (195, 4)
```

---

### Block 1024

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (196, 4)
```

---

### Block 1025

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (197, 4)
```

---

### Block 1026

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (198, 7)
```

---

### Block 1027

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (179, 4)
```

---

### Block 1028

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (180, 4)
```

---

### Block 1029

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (181, 4)
```

---

### Block 1030

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (182, 4)
```

---

### Block 1031

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (183, 4)
```

---

### Block 1032

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (199, 9)
```

---

### Block 1033

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (200, 9)
```

---

### Block 1034

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (201, 9)
```

---

### Block 1035

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (202, 9)
```

---

### Block 1036

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (203, 9)
```

---

### Block 1037

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (204, 9)
```

---

### Block 1038

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (205, 9)
```

---

### Block 1039

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (206, 9)
```

---

### Block 1040

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (207, 9)
```

---

### Block 1041

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (208, 9)
```

---

### Block 1042

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (209, 9)
```

---

### Block 1043

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (210, 9)
```

---

### Block 1044

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (211, 9)
```

---

### Block 1045

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (212, 8)
```

---

### Block 1046

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (213, 8)
```

---

### Block 1047

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (214, 8)
```

---

### Block 1048

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (215, 4)
```

---

### Block 1049

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 6)
```

---

### Block 1050

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (217, 7)
```

---

### Block 1051

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (218, 2)
```

---

### Block 1052

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (219, 2)
```

---

### Block 1053

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (220, 8)
```

---

### Block 1054

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 2)
```

---

### Block 1055

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 10)
```

---

### Block 1056

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (222, 10)
```

---

### Block 1057

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (223, 10)
```

---

### Block 1058

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (224, 10)
```

---

### Block 1059

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (225, 10)
```

---

### Block 1060

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 2)
```

---

### Block 1061

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 10)
```

---

### Block 1062

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (227, 10)
```

---

### Block 1063

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 2)
```

---

### Block 1064

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 10)
```

---

### Block 1065

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (229, 7)
```

---

### Block 1066

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (230, 8)
```

---

### Block 1067

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (233, 8)
```

---

### Block 1068

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (234, 8)
```

---

### Block 1069

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (235, 2)
```

---

### Block 1070

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 6)
```

---

### Block 1071

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 8)
```

---

### Block 1072

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (237, 6)
```

---

### Block 1073

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (238, 6)
```

---

### Block 1074

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 2)
```

---

### Block 1075

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 3)
```

---

### Block 1076

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 2)
```

---

### Block 1077

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 3)
```

---

### Block 1078

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (241, 8)
```

---

### Block 1079

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (242, 8)
```

---

### Block 1080

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (243, 8)
```

---

### Block 1081

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (244, 8)
```

---

### Block 1082

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (245, 8)
```

---

### Block 1083

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (246, 8)
```

---

### Block 1084

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 2)
```

---

### Block 1085

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 11)
```

---

### Block 1086

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 2)
```

---

### Block 1087

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 11)
```

---

### Block 1088

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 2)
```

---

### Block 1089

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 11)
```

---

### Block 1090

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (1, 1)
```

---

### Block 1091

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (2, 1)
```

---

### Block 1092

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 2)
```

---

### Block 1093

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 7)
```

---

### Block 1094

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (4, 7)
```

---

### Block 1095

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (5, 7)
```

---

### Block 1096

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (6, 7)
```

---

### Block 1097

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (7, 7)
```

---

### Block 1098

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (8, 7)
```

---

### Block 1099

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (9, 7)
```

---

### Block 1100

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (10, 7)
```

---

### Block 1101

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (11, 7)
```

---

### Block 1102

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (12, 7)
```

---

### Block 1103

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (13, 7)
```

---

### Block 1104

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (14, 7)
```

---

### Block 1105

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (15, 7)
```

---

### Block 1106

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (16, 7)
```

---

### Block 1107

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (17, 7)
```

---

### Block 1108

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 2)
```

---

### Block 1109

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 7)
```

---

### Block 1110

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 2)
```

---

### Block 1111

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 7)
```

---

### Block 1112

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (20, 7)
```

---

### Block 1113

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (21, 7)
```

---

### Block 1114

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (22, 7)
```

---

### Block 1115

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (23, 7)
```

---

### Block 1116

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (24, 7)
```

---

### Block 1117

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (25, 7)
```

---

### Block 1118

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (26, 7)
```

---

### Block 1119

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (27, 7)
```

---

### Block 1120

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 2)
```

---

### Block 1121

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (28, 8)
```

---

### Block 1122

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 6)
```

---

### Block 1123

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (29, 8)
```

---

### Block 1124

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (232, 8)
```

---

### Block 1125

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (30, 8)
```

---

### Block 1126

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 7)
```

---

### Block 1127

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 8)
```

---

### Block 1128

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (32, 4)
```

---

### Block 1129

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (33, 4)
```

---

### Block 1130

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (34, 4)
```

---

### Block 1131

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (35, 4)
```

---

### Block 1132

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (36, 4)
```

---

### Block 1133

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (37, 4)
```

---

### Block 1134

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (38, 4)
```

---

### Block 1135

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (39, 4)
```

---

### Block 1136

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (40, 4)
```

---

### Block 1137

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (41, 4)
```

---

### Block 1138

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (42, 4)
```

---

### Block 1139

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (43, 4)
```

---

### Block 1140

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (44, 4)
```

---

### Block 1141

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (45, 4)
```

---

### Block 1142

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (46, 4)
```

---

### Block 1143

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 3)
```

---

### Block 1144

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 4)
```

---

### Block 1145

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 6)
```

---

### Block 1146

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 8)
```

---

### Block 1147

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 3)
```

---

### Block 1148

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 4)
```

---

### Block 1149

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 6)
```

---

### Block 1150

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 8)
```

---

### Block 1151

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 4)
```

---

### Block 1152

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 8)
```

---

### Block 1153

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 4)
```

---

### Block 1154

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 8)
```

---

### Block 1155

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 4)
```

---

### Block 1156

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 8)
```

---

### Block 1157

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 4)
```

---

### Block 1158

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 8)
```

---

### Block 1159

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 4)
```

---

### Block 1160

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 8)
```

---

### Block 1161

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 4)
```

---

### Block 1162

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 8)
```

---

### Block 1163

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 4)
```

---

### Block 1164

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 8)
```

---

### Block 1165

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 4)
```

---

### Block 1166

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 8)
```

---

### Block 1167

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 4)
```

---

### Block 1168

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 8)
```

---

### Block 1169

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 4)
```

---

### Block 1170

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 8)
```

---

### Block 1171

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 4)
```

---

### Block 1172

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 8)
```

---

### Block 1173

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 4)
```

---

### Block 1174

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 8)
```

---

### Block 1175

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 3)
```

---

### Block 1176

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 6)
```

---

### Block 1177

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 3)
```

---

### Block 1178

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 6)
```

---

### Block 1179

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (63, 3)
```

---

### Block 1180

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (64, 3)
```

---

### Block 1181

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (65, 3)
```

---

### Block 1182

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 3)
```

---

### Block 1183

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 6)
```

---

### Block 1184

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 6)
```

---

### Block 1185

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 3)
```

---

### Block 1186

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (68, 6)
```

---

### Block 1187

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 3)
```

---

### Block 1188

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 2)
```

---

### Block 1189

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 3)
```

---

### Block 1190

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 2)
```

---

### Block 1191

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (71, 3)
```

---

### Block 1192

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (72, 3)
```

---

### Block 1193

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 3)
```

---

### Block 1194

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 2)
```

---

### Block 1195

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (74, 3)
```

---

### Block 1196

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 3)
```

---

### Block 1197

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 6)
```

---

### Block 1198

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 3)
```

---

### Block 1199

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 6)
```

---

### Block 1200

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 8)
```

---

### Block 1201

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 3)
```

---

### Block 1202

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 6)
```

---

### Block 1203

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 8)
```

---

### Block 1204

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 3)
```

---

### Block 1205

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 6)
```

---

### Block 1206

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 8)
```

---

### Block 1207

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 4)
```

---

### Block 1208

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 5)
```

---

### Block 1209

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 6)
```

---

### Block 1210

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 8)
```

---

### Block 1211

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 3)
```

---

### Block 1212

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 6)
```

---

### Block 1213

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 8)
```

---

### Block 1214

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (81, 3)
```

---

### Block 1215

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (82, 5)
```

---

### Block 1216

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (83, 5)
```

---

### Block 1217

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (84, 5)
```

---

### Block 1218

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (85, 5)
```

---

### Block 1219

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (86, 5)
```

---

### Block 1220

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 2)
```

---

### Block 1221

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 5)
```

---

### Block 1222

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 2)
```

---

### Block 1223

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 5)
```

---

### Block 1224

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 2)
```

---

### Block 1225

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 5)
```

---

### Block 1226

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 2)
```

---

### Block 1227

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 5)
```

---

### Block 1228

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 2)
```

---

### Block 1229

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 5)
```

---

### Block 1230

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 2)
```

---

### Block 1231

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 5)
```

---

### Block 1232

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 2)
```

---

### Block 1233

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 5)
```

---

### Block 1234

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 2)
```

---

### Block 1235

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 5)
```

---

### Block 1236

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 2)
```

---

### Block 1237

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 5)
```

---

### Block 1238

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 2)
```

---

### Block 1239

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 5)
```

---

### Block 1240

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 2)
```

---

### Block 1241

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 5)
```

---

### Block 1242

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 2)
```

---

### Block 1243

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 5)
```

---

### Block 1244

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 2)
```

---

### Block 1245

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 5)
```

---

### Block 1246

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 2)
```

---

### Block 1247

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 5)
```

---

### Block 1248

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 2)
```

---

### Block 1249

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 5)
```

---

### Block 1250

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 2)
```

---

### Block 1251

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 5)
```

---

### Block 1252

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (103, 5)
```

---

### Block 1253

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (104, 5)
```

---

### Block 1254

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 2)
```

---

### Block 1255

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 5)
```

---

### Block 1256

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (106, 5)
```

---

### Block 1257

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (107, 5)
```

---

### Block 1258

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 2)
```

---

### Block 1259

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 3)
```

---

### Block 1260

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 4)
```

---

### Block 1261

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 5)
```

---

### Block 1262

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 6)
```

---

### Block 1263

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 7)
```

---

### Block 1264

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (109, 6)
```

---

### Block 1265

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (110, 6)
```

---

### Block 1266

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (111, 6)
```

---

### Block 1267

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (112, 6)
```

---

### Block 1268

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (113, 6)
```

---

### Block 1269

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (114, 6)
```

---

### Block 1270

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (115, 6)
```

---

### Block 1271

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (116, 6)
```

---

### Block 1272

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (117, 6)
```

---

### Block 1273

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (118, 6)
```

---

### Block 1274

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (119, 6)
```

---

### Block 1275

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (120, 6)
```

---

### Block 1276

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (121, 6)
```

---

### Block 1277

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (122, 6)
```

---

### Block 1278

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (123, 6)
```

---

### Block 1279

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (124, 6)
```

---

### Block 1280

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (125, 6)
```

---

### Block 1281

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (126, 6)
```

---

### Block 1282

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (127, 6)
```

---

### Block 1283

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (128, 6)
```

---

### Block 1284

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 6)
```

---

### Block 1285

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 8)
```

---

### Block 1286

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 6)
```

---

### Block 1287

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 8)
```

---

### Block 1288

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 6)
```

---

### Block 1289

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 8)
```

---

### Block 1290

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 6)
```

---

### Block 1291

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 8)
```

---

### Block 1292

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 6)
```

---

### Block 1293

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 8)
```

---

### Block 1294

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 6)
```

---

### Block 1295

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 8)
```

---

### Block 1296

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 6)
```

---

### Block 1297

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 8)
```

---

### Block 1298

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 6)
```

---

### Block 1299

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 8)
```

---

### Block 1300

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 6)
```

---

### Block 1301

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 8)
```

---

### Block 1302

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 6)
```

---

### Block 1303

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 8)
```

---

### Block 1304

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 6)
```

---

### Block 1305

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 8)
```

---

### Block 1306

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 6)
```

---

### Block 1307

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 8)
```

---

### Block 1308

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 6)
```

---

### Block 1309

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 8)
```

---

### Block 1310

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 6)
```

---

### Block 1311

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 8)
```

---

### Block 1312

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 6)
```

---

### Block 1313

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 8)
```

---

### Block 1314

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 6)
```

---

### Block 1315

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 8)
```

---

### Block 1316

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 6)
```

---

### Block 1317

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 8)
```

---

### Block 1318

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 6)
```

---

### Block 1319

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 8)
```

---

### Block 1320

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 6)
```

---

### Block 1321

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 8)
```

---

### Block 1322

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (148, 2)
```

---

### Block 1323

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (149, 2)
```

---

### Block 1324

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (150, 2)
```

---

### Block 1325

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (151, 2)
```

---

### Block 1326

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (152, 2)
```

---

### Block 1327

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (153, 2)
```

---

### Block 1328

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (154, 2)
```

---

### Block 1329

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (155, 2)
```

---

### Block 1330

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (156, 2)
```

---

### Block 1331

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 2)
```

---

### Block 1332

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 6)
```

---

### Block 1333

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (158, 2)
```

---

### Block 1334

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (159, 2)
```

---

### Block 1335

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (160, 2)
```

---

### Block 1336

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 2)
```

---

### Block 1337

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 6)
```

---

### Block 1338

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 8)
```

---

### Block 1339

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 2)
```

---

### Block 1340

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 6)
```

---

### Block 1341

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 8)
```

---

### Block 1342

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 2)
```

---

### Block 1343

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 6)
```

---

### Block 1344

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 8)
```

---

### Block 1345

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 2)
```

---

### Block 1346

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 6)
```

---

### Block 1347

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 8)
```

---

### Block 1348

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 2)
```

---

### Block 1349

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 8)
```

---

### Block 1350

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 2)
```

---

### Block 1351

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 6)
```

---

### Block 1352

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 2)
```

---

### Block 1353

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 6)
```

---

### Block 1354

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 2)
```

---

### Block 1355

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 6)
```

---

### Block 1356

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 2)
```

---

### Block 1357

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 6)
```

---

### Block 1358

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 2)
```

---

### Block 1359

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 6)
```

---

### Block 1360

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (171, 6)
```

---

### Block 1361

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 2)
```

---

### Block 1362

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 8)
```

---

### Block 1363

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (173, 2)
```

---

### Block 1364

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (174, 2)
```

---

### Block 1365

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (175, 2)
```

---

### Block 1366

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 2)
```

---

### Block 1367

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 6)
```

---

### Block 1368

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (177, 2)
```

---

### Block 1369

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (178, 2)
```

---

### Block 1370

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (184, 4)
```

---

### Block 1371

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (185, 4)
```

---

### Block 1372

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (186, 4)
```

---

### Block 1373

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (187, 4)
```

---

### Block 1374

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (188, 4)
```

---

### Block 1375

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (189, 4)
```

---

### Block 1376

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (190, 4)
```

---

### Block 1377

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 2)
```

---

### Block 1378

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (192, 4)
```

---

### Block 1379

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (193, 4)
```

---

### Block 1380

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (194, 4)
```

---

### Block 1381

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (195, 4)
```

---

### Block 1382

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (196, 4)
```

---

### Block 1383

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (197, 4)
```

---

### Block 1384

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (198, 7)
```

---

### Block 1385

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (179, 4)
```

---

### Block 1386

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (180, 4)
```

---

### Block 1387

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (181, 4)
```

---

### Block 1388

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (182, 4)
```

---

### Block 1389

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (183, 4)
```

---

### Block 1390

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (199, 9)
```

---

### Block 1391

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (200, 9)
```

---

### Block 1392

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (201, 9)
```

---

### Block 1393

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (202, 9)
```

---

### Block 1394

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (203, 9)
```

---

### Block 1395

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (204, 9)
```

---

### Block 1396

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (205, 9)
```

---

### Block 1397

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (206, 9)
```

---

### Block 1398

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (207, 9)
```

---

### Block 1399

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (208, 9)
```

---

### Block 1400

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (209, 9)
```

---

### Block 1401

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (210, 9)
```

---

### Block 1402

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (211, 9)
```

---

### Block 1403

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (212, 8)
```

---

### Block 1404

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (213, 8)
```

---

### Block 1405

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (214, 8)
```

---

### Block 1406

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (215, 4)
```

---

### Block 1407

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 6)
```

---

### Block 1408

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (217, 7)
```

---

### Block 1409

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (218, 2)
```

---

### Block 1410

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (219, 2)
```

---

### Block 1411

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (220, 8)
```

---

### Block 1412

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 2)
```

---

### Block 1413

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 10)
```

---

### Block 1414

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (222, 10)
```

---

### Block 1415

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (223, 10)
```

---

### Block 1416

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (224, 10)
```

---

### Block 1417

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (225, 10)
```

---

### Block 1418

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 2)
```

---

### Block 1419

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 10)
```

---

### Block 1420

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (227, 10)
```

---

### Block 1421

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 2)
```

---

### Block 1422

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 10)
```

---

### Block 1423

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (229, 7)
```

---

### Block 1424

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (230, 8)
```

---

### Block 1425

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (233, 8)
```

---

### Block 1426

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (234, 8)
```

---

### Block 1427

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (235, 2)
```

---

### Block 1428

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 6)
```

---

### Block 1429

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 8)
```

---

### Block 1430

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (237, 6)
```

---

### Block 1431

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (238, 6)
```

---

### Block 1432

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 2)
```

---

### Block 1433

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 3)
```

---

### Block 1434

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 2)
```

---

### Block 1435

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 3)
```

---

### Block 1436

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (241, 8)
```

---

### Block 1437

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (242, 8)
```

---

### Block 1438

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (243, 8)
```

---

### Block 1439

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (244, 8)
```

---

### Block 1440

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (245, 8)
```

---

### Block 1441

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (246, 8)
```

---

### Block 1442

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 2)
```

---

### Block 1443

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 11)
```

---

### Block 1444

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 2)
```

---

### Block 1445

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 11)
```

---

### Block 1446

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 2)
```

---

### Block 1447

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 11)
```

---

### Block 1448

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (1, 1)
```

---

### Block 1449

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (2, 1)
```

---

### Block 1450

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 2)
```

---

### Block 1451

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (3, 7)
```

---

### Block 1452

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (4, 7)
```

---

### Block 1453

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (5, 7)
```

---

### Block 1454

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (6, 7)
```

---

### Block 1455

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (7, 7)
```

---

### Block 1456

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (8, 7)
```

---

### Block 1457

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (9, 7)
```

---

### Block 1458

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (10, 7)
```

---

### Block 1459

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (11, 7)
```

---

### Block 1460

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (12, 7)
```

---

### Block 1461

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (13, 7)
```

---

### Block 1462

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (14, 7)
```

---

### Block 1463

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (15, 7)
```

---

### Block 1464

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (16, 7)
```

---

### Block 1465

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (17, 7)
```

---

### Block 1466

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 2)
```

---

### Block 1467

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (18, 7)
```

---

### Block 1468

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 2)
```

---

### Block 1469

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (19, 7)
```

---

### Block 1470

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (20, 7)
```

---

### Block 1471

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (21, 7)
```

---

### Block 1472

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (22, 7)
```

---

### Block 1473

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (23, 7)
```

---

### Block 1474

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (24, 7)
```

---

### Block 1475

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (25, 7)
```

---

### Block 1476

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (26, 7)
```

---

### Block 1477

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (27, 7)
```

---

### Block 1478

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 2)
```

---

### Block 1479

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (28, 8)
```

---

### Block 1480

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (231, 6)
```

---

### Block 1481

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (29, 8)
```

---

### Block 1482

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (232, 8)
```

---

### Block 1483

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (30, 8)
```

---

### Block 1484

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 7)
```

---

### Block 1485

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (31, 8)
```

---

### Block 1486

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (32, 4)
```

---

### Block 1487

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (33, 4)
```

---

### Block 1488

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (34, 4)
```

---

### Block 1489

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (35, 4)
```

---

### Block 1490

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (36, 4)
```

---

### Block 1491

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (37, 4)
```

---

### Block 1492

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (38, 4)
```

---

### Block 1493

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (39, 4)
```

---

### Block 1494

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (40, 4)
```

---

### Block 1495

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (41, 4)
```

---

### Block 1496

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (42, 4)
```

---

### Block 1497

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (43, 4)
```

---

### Block 1498

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (44, 4)
```

---

### Block 1499

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (45, 4)
```

---

### Block 1500

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (46, 4)
```

---

### Block 1501

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 3)
```

---

### Block 1502

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 4)
```

---

### Block 1503

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 6)
```

---

### Block 1504

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (47, 8)
```

---

### Block 1505

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 3)
```

---

### Block 1506

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 4)
```

---

### Block 1507

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 6)
```

---

### Block 1508

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (48, 8)
```

---

### Block 1509

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 4)
```

---

### Block 1510

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (49, 8)
```

---

### Block 1511

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 4)
```

---

### Block 1512

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (50, 8)
```

---

### Block 1513

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 4)
```

---

### Block 1514

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (51, 8)
```

---

### Block 1515

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 4)
```

---

### Block 1516

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (52, 8)
```

---

### Block 1517

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 4)
```

---

### Block 1518

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (53, 8)
```

---

### Block 1519

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 4)
```

---

### Block 1520

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (54, 8)
```

---

### Block 1521

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 4)
```

---

### Block 1522

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (55, 8)
```

---

### Block 1523

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 4)
```

---

### Block 1524

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (56, 8)
```

---

### Block 1525

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 4)
```

---

### Block 1526

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (57, 8)
```

---

### Block 1527

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 4)
```

---

### Block 1528

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (58, 8)
```

---

### Block 1529

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 4)
```

---

### Block 1530

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (59, 8)
```

---

### Block 1531

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 4)
```

---

### Block 1532

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (60, 8)
```

---

### Block 1533

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 3)
```

---

### Block 1534

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (61, 6)
```

---

### Block 1535

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 3)
```

---

### Block 1536

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (62, 6)
```

---

### Block 1537

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (63, 3)
```

---

### Block 1538

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (64, 3)
```

---

### Block 1539

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (65, 3)
```

---

### Block 1540

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 3)
```

---

### Block 1541

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (66, 6)
```

---

### Block 1542

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 6)
```

---

### Block 1543

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (67, 3)
```

---

### Block 1544

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (68, 6)
```

---

### Block 1545

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 3)
```

---

### Block 1546

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (69, 2)
```

---

### Block 1547

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 3)
```

---

### Block 1548

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (70, 2)
```

---

### Block 1549

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (71, 3)
```

---

### Block 1550

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (72, 3)
```

---

### Block 1551

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 3)
```

---

### Block 1552

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (73, 2)
```

---

### Block 1553

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (74, 3)
```

---

### Block 1554

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 3)
```

---

### Block 1555

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (75, 6)
```

---

### Block 1556

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 3)
```

---

### Block 1557

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 6)
```

---

### Block 1558

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (76, 8)
```

---

### Block 1559

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 3)
```

---

### Block 1560

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 6)
```

---

### Block 1561

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (77, 8)
```

---

### Block 1562

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 3)
```

---

### Block 1563

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 6)
```

---

### Block 1564

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (78, 8)
```

---

### Block 1565

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 4)
```

---

### Block 1566

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 5)
```

---

### Block 1567

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 6)
```

---

### Block 1568

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (79, 8)
```

---

### Block 1569

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 3)
```

---

### Block 1570

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 6)
```

---

### Block 1571

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (80, 8)
```

---

### Block 1572

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (81, 3)
```

---

### Block 1573

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (82, 5)
```

---

### Block 1574

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (83, 5)
```

---

### Block 1575

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (84, 5)
```

---

### Block 1576

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (85, 5)
```

---

### Block 1577

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (86, 5)
```

---

### Block 1578

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 2)
```

---

### Block 1579

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (87, 5)
```

---

### Block 1580

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 2)
```

---

### Block 1581

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (88, 5)
```

---

### Block 1582

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 2)
```

---

### Block 1583

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (89, 5)
```

---

### Block 1584

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 2)
```

---

### Block 1585

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (90, 5)
```

---

### Block 1586

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 2)
```

---

### Block 1587

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (91, 5)
```

---

### Block 1588

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 2)
```

---

### Block 1589

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (92, 5)
```

---

### Block 1590

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 2)
```

---

### Block 1591

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (93, 5)
```

---

### Block 1592

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 2)
```

---

### Block 1593

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (94, 5)
```

---

### Block 1594

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 2)
```

---

### Block 1595

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (95, 5)
```

---

### Block 1596

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 2)
```

---

### Block 1597

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (96, 5)
```

---

### Block 1598

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 2)
```

---

### Block 1599

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (97, 5)
```

---

### Block 1600

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 2)
```

---

### Block 1601

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (98, 5)
```

---

### Block 1602

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 2)
```

---

### Block 1603

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (99, 5)
```

---

### Block 1604

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 2)
```

---

### Block 1605

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (100, 5)
```

---

### Block 1606

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 2)
```

---

### Block 1607

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (101, 5)
```

---

### Block 1608

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 2)
```

---

### Block 1609

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (102, 5)
```

---

### Block 1610

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (103, 5)
```

---

### Block 1611

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (104, 5)
```

---

### Block 1612

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 2)
```

---

### Block 1613

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (105, 5)
```

---

### Block 1614

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (106, 5)
```

---

### Block 1615

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (107, 5)
```

---

### Block 1616

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 2)
```

---

### Block 1617

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 3)
```

---

### Block 1618

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 4)
```

---

### Block 1619

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 5)
```

---

### Block 1620

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 6)
```

---

### Block 1621

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (108, 7)
```

---

### Block 1622

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (109, 6)
```

---

### Block 1623

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (110, 6)
```

---

### Block 1624

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (111, 6)
```

---

### Block 1625

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (112, 6)
```

---

### Block 1626

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (113, 6)
```

---

### Block 1627

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (114, 6)
```

---

### Block 1628

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (115, 6)
```

---

### Block 1629

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (116, 6)
```

---

### Block 1630

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (117, 6)
```

---

### Block 1631

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (118, 6)
```

---

### Block 1632

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (119, 6)
```

---

### Block 1633

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (120, 6)
```

---

### Block 1634

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (121, 6)
```

---

### Block 1635

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (122, 6)
```

---

### Block 1636

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (123, 6)
```

---

### Block 1637

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (124, 6)
```

---

### Block 1638

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (125, 6)
```

---

### Block 1639

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (126, 6)
```

---

### Block 1640

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (127, 6)
```

---

### Block 1641

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (128, 6)
```

---

### Block 1642

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 6)
```

---

### Block 1643

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (129, 8)
```

---

### Block 1644

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 6)
```

---

### Block 1645

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (130, 8)
```

---

### Block 1646

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 6)
```

---

### Block 1647

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (131, 8)
```

---

### Block 1648

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 6)
```

---

### Block 1649

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (132, 8)
```

---

### Block 1650

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 6)
```

---

### Block 1651

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (133, 8)
```

---

### Block 1652

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 6)
```

---

### Block 1653

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (134, 8)
```

---

### Block 1654

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 6)
```

---

### Block 1655

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (135, 8)
```

---

### Block 1656

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 6)
```

---

### Block 1657

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (136, 8)
```

---

### Block 1658

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 6)
```

---

### Block 1659

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (137, 8)
```

---

### Block 1660

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 6)
```

---

### Block 1661

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (138, 8)
```

---

### Block 1662

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 6)
```

---

### Block 1663

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (139, 8)
```

---

### Block 1664

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 6)
```

---

### Block 1665

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (140, 8)
```

---

### Block 1666

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 6)
```

---

### Block 1667

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (141, 8)
```

---

### Block 1668

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 6)
```

---

### Block 1669

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (142, 8)
```

---

### Block 1670

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 6)
```

---

### Block 1671

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (143, 8)
```

---

### Block 1672

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 6)
```

---

### Block 1673

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (144, 8)
```

---

### Block 1674

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 6)
```

---

### Block 1675

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (145, 8)
```

---

### Block 1676

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 6)
```

---

### Block 1677

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (146, 8)
```

---

### Block 1678

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 6)
```

---

### Block 1679

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (147, 8)
```

---

### Block 1680

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (148, 2)
```

---

### Block 1681

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (149, 2)
```

---

### Block 1682

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (150, 2)
```

---

### Block 1683

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (151, 2)
```

---

### Block 1684

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (152, 2)
```

---

### Block 1685

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (153, 2)
```

---

### Block 1686

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (154, 2)
```

---

### Block 1687

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (155, 2)
```

---

### Block 1688

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (156, 2)
```

---

### Block 1689

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 2)
```

---

### Block 1690

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (157, 6)
```

---

### Block 1691

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (158, 2)
```

---

### Block 1692

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (159, 2)
```

---

### Block 1693

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (160, 2)
```

---

### Block 1694

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 2)
```

---

### Block 1695

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 6)
```

---

### Block 1696

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (161, 8)
```

---

### Block 1697

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 2)
```

---

### Block 1698

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 6)
```

---

### Block 1699

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (162, 8)
```

---

### Block 1700

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 2)
```

---

### Block 1701

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 6)
```

---

### Block 1702

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (163, 8)
```

---

### Block 1703

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 2)
```

---

### Block 1704

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 6)
```

---

### Block 1705

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (164, 8)
```

---

### Block 1706

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 2)
```

---

### Block 1707

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (165, 8)
```

---

### Block 1708

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 2)
```

---

### Block 1709

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (166, 6)
```

---

### Block 1710

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 2)
```

---

### Block 1711

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (167, 6)
```

---

### Block 1712

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 2)
```

---

### Block 1713

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (168, 6)
```

---

### Block 1714

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 2)
```

---

### Block 1715

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (169, 6)
```

---

### Block 1716

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 2)
```

---

### Block 1717

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (170, 6)
```

---

### Block 1718

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (171, 6)
```

---

### Block 1719

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 2)
```

---

### Block 1720

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (172, 8)
```

---

### Block 1721

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (173, 2)
```

---

### Block 1722

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (174, 2)
```

---

### Block 1723

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (175, 2)
```

---

### Block 1724

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 2)
```

---

### Block 1725

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (176, 6)
```

---

### Block 1726

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (177, 2)
```

---

### Block 1727

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (178, 2)
```

---

### Block 1728

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (184, 4)
```

---

### Block 1729

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (185, 4)
```

---

### Block 1730

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (186, 4)
```

---

### Block 1731

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (187, 4)
```

---

### Block 1732

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (188, 4)
```

---

### Block 1733

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (189, 4)
```

---

### Block 1734

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (190, 4)
```

---

### Block 1735

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 2)
```

---

### Block 1736

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (192, 4)
```

---

### Block 1737

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (193, 4)
```

---

### Block 1738

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (194, 4)
```

---

### Block 1739

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (195, 4)
```

---

### Block 1740

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (196, 4)
```

---

### Block 1741

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (197, 4)
```

---

### Block 1742

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (198, 7)
```

---

### Block 1743

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (179, 4)
```

---

### Block 1744

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (180, 4)
```

---

### Block 1745

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (181, 4)
```

---

### Block 1746

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (182, 4)
```

---

### Block 1747

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (183, 4)
```

---

### Block 1748

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (199, 9)
```

---

### Block 1749

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (200, 9)
```

---

### Block 1750

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (201, 9)
```

---

### Block 1751

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (202, 9)
```

---

### Block 1752

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (203, 9)
```

---

### Block 1753

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (204, 9)
```

---

### Block 1754

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (205, 9)
```

---

### Block 1755

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (206, 9)
```

---

### Block 1756

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (207, 9)
```

---

### Block 1757

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (208, 9)
```

---

### Block 1758

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (209, 9)
```

---

### Block 1759

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (210, 9)
```

---

### Block 1760

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (211, 9)
```

---

### Block 1761

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (212, 8)
```

---

### Block 1762

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (213, 8)
```

---

### Block 1763

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (214, 8)
```

---

### Block 1764

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (215, 4)
```

---

### Block 1765

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (216, 6)
```

---

### Block 1766

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (217, 7)
```

---

### Block 1767

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (218, 2)
```

---

### Block 1768

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (219, 2)
```

---

### Block 1769

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (220, 8)
```

---

### Block 1770

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 2)
```

---

### Block 1771

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (221, 10)
```

---

### Block 1772

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (222, 10)
```

---

### Block 1773

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (223, 10)
```

---

### Block 1774

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (224, 10)
```

---

### Block 1775

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (225, 10)
```

---

### Block 1776

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 2)
```

---

### Block 1777

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (226, 10)
```

---

### Block 1778

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (227, 10)
```

---

### Block 1779

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 2)
```

---

### Block 1780

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (228, 10)
```

---

### Block 1781

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (229, 7)
```

---

### Block 1782

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (230, 8)
```

---

### Block 1783

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (233, 8)
```

---

### Block 1784

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (234, 8)
```

---

### Block 1785

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (235, 2)
```

---

### Block 1786

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 6)
```

---

### Block 1787

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (236, 8)
```

---

### Block 1788

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (237, 6)
```

---

### Block 1789

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (238, 6)
```

---

### Block 1790

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 2)
```

---

### Block 1791

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (239, 3)
```

---

### Block 1792

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 2)
```

---

### Block 1793

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (240, 3)
```

---

### Block 1794

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (241, 8)
```

---

### Block 1795

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (242, 8)
```

---

### Block 1796

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (243, 8)
```

---

### Block 1797

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (244, 8)
```

---

### Block 1798

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (245, 8)
```

---

### Block 1799

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (246, 8)
```

---

### Block 1800

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 2)
```

---

### Block 1801

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (247, 11)
```

---

### Block 1802

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 2)
```

---

### Block 1803

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (248, 11)
```

---

### Block 1804

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 2)
```

---

### Block 1805

```sql
INSERT [dbo].[AuditActionsCategories] ([AuditActionID], [AuditCategoryID]) VALUES (249, 11)
```

---

### Block 1806

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (1, N'General')
```

---

### Block 1807

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (2, N'JobAccounting')
```

---

### Block 1808

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (3, N'LocalInventory')
```

---

### Block 1809

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (4, N'ForceAuthentication')
```

---

### Block 1810

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (5, N'AuditJobContent')
```

---

### Block 1811

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (6, N'StampLogon')
```

---

### Block 1812

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (7, N'SessionMemory')
```

---

### Block 1813

```sql
INSERT [dbo].[PoliciesParametersTypes] ([PolicyParameterTypeID], [PolicyParameterTypeName]) VALUES (8, N'CostAccounts')
```

---

### Block 1814

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'BillingCorporativeDisplayName', N'@@Corporative.ShortName', N'Indica o nome de exibição do termo corporativo')
```

---

### Block 1815

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'BillingPrivateEnabled', N'0', N'Habilita a indicação do tipo particular nas impressões')
```

---

### Block 1816

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'BillingTargetDisplayName', N'@@BillingTarget', N'Indica o nome de exibição da escolha entre corporativo e particular')
```

---

### Block 1817

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'DecimalPlaces', N'2', N'Indica a quantidade de casas decimais utilizadas nos valores de impressão')
```

---

### Block 1818

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'OfflineBehavior', N'Print', N'Indica o comportamento dos agentes quando estiverem sem comunicação com o servidor) e os valores possíveis serão: Print e Block')
```

---

### Block 1819

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'PrinterSessionTimeout', N'120', N'Indica a quantidade de segundos antes da impressora realizar o timeout')
```

---

### Block 1820

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'PrintPolicyDefaultAlertMessage', N'@@PrintPolicyDefaultAlertMessage', N'Define a mensagem padrão de alerta exibida nas políticas')
```

---

### Block 1821

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'PrintPolicyDefaultNotifyMessage', N'@@PrintPolicyDefaultNotifyMessage', N'Define a mensagem padrão de notificação exibida nas políticas')
```

---

### Block 1822

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'ShowCosts', N'1', N'Habilita a exibição dos custos de impressão aos usuários durante as impressões')
```

---

### Block 1823

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'ShowMFDDenyAlerts', N'1', N'Habilita as mensagens de negação do n-Control')
```

---

### Block 1824

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'ShowMFDQuotas', N'1', N'Habilita as mensagens de cotas do n-Control')
```

---

### Block 1825

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (1, N'UseStandardsPoliciesSettingsForManagers', N'0', N'Indica se serão usadas configurações padrões de políticas para gerentes.')
```

---

### Block 1826

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'AcLPDPort', N'0', N'Habilita ou desabilita a bilhetagem das portas LPD')
```

---

### Block 1827

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'AcRemotePort', N'0', N'Habilita ou desabilita a bilhetagem das portas remotas')
```

---

### Block 1828

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'ERPDomain', N'', N'Contém o nome do domínio que um job deve ser atribuído quando entra nas regras de um ERP')
```

---

### Block 1829

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'ERPNameHability', N'0', N'Habilita a o processo diferenciado de bilhetagem do ERP')
```

---

### Block 1830

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'ERPSplitOrder', N'0', N'Indica a order para divisão do título e usuário. 0 = Título e usuário, 1 = Usuário e título')
```

---

### Block 1831

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'ERPTagUser', N'', N'Indica o caracter separador entre o título do documento e usuário')
```

---

### Block 1832

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'ForceDomain', N'', N'Contém o nome do domínio que os jobs devem ser atribuídos, não utiliza o domínio local ou domínio do usuário')
```

---

### Block 1833

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'MaxJobsTimeOuts', N'5', N'Maxima quantidade de jobs armazenados na pasta timeout')
```

---

### Block 1834

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'MaxJobsWarning', N'5', N'Equivale ao numero máximo de arquivos armazenados na pasta Logs')
```

---

### Block 1835

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'MinimumJobSize', N'100', N'Define o tamanho mínimo do job a ser bilhetado (em bytes)')
```

---

### Block 1836

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'PJLUserAnalyze', N'', N'Contém o nome do usuário que deve ser trocado pelo usuário dentro do arquivo PJL')
```

---

### Block 1837

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'PrintersDataSNMPv3Enabled', N'0', N'Habilita a busca de informações das impressoras nos ambientes com SNMP v3.')
```

---

### Block 1838

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'SNMPCommunity', N'', N'Comunidade configurada na impressora para pegar os dados via SNMP')
```

---

### Block 1839

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'Timeout', N'20', N'Indica o tempo máximo (em minutos) de processamento de um arquivo de spool')
```

---

### Block 1840

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'TimeUpdate', N'30', N'Intervalo de tempo para envio dos arquivos para o n-Host (em minutos)')
```

---

### Block 1841

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'UseNovell', N'0', N'Habilita o processo de trocar o usuário do job pelo contido nas chaves da novell')
```

---

### Block 1842

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'UserDelimiter', N'', N'Contém os delimitadores para as regras de PA ERP')
```

---

### Block 1843

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (2, N'Warning', N'1000', N'Valor utilizado para guardar arquivos de spool (valor em paginas). Quando uma bilhetagem ultrapassa o valor deste campo os arquivos são copiados para pasta logs.')
```

---

### Block 1844

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (3, N'InventoryTimeUpdate', N'120', N'Intervalo de tempo (em minutos) de envio do relatório de impressoras USB')
```

---

### Block 1845

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (3, N'LocalInventoryEnabled', N'0', N'Habilita a captura de contadores das impressoras USB')
```

---

### Block 1846

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (4, N'DisabledDomainsAuthentication', N'', N'Contém a lista de domínios que o usuário não precisará efetuar logon caso já esteja logado neles.')
```

---

### Block 1847

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (4, N'ForceAuthenticationEnabled', N'0', N'Habilita a solicitação de autenticação dos usuários')
```

---

### Block 1848

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (5, N'AuditCancelledJobs', N'0', N'Indica se os jobs cancelados também serão auditados')
```

---

### Block 1849

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (5, N'AuditIntervalToSend', N'120', N'Intervalo que os arquivos devem serem enviados (em minutos)')
```

---

### Block 1850

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (5, N'AuditJobContentEnabled', N'0', N'Habilita a auditoria das impressões')
```

---

### Block 1851

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (5, N'AuditJobServer', N'', N'Nome do servidor de auditoria que devem ser enviados os arquivos')
```

---

### Block 1852

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'Border', N'Left', N'Indica se o login será impresso no topo (Top) ou na lateral (Left)')
```

---

### Block 1853

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'FontSize', N'4', N'Indica o tamanho da fonte que será usada para impressão da identificação do usuário (2,4 ou 6)')
```

---

### Block 1854

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'ShowDateInfo', N'0', N'Indica se exibe a data no documento como marca de impressão')
```

---

### Block 1855

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'ShowDomainInfo', N'0', N'Indica se exibe o domínio do usuário no documento como marca de impressão')
```

---

### Block 1856

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'ShowTimeInfo', N'0', N'Indica se exibe a hora no documento como marca de impressão')
```

---

### Block 1857

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'StampLogonEnabled', N'1', N'Indica se a marca de impressão está habilitada')
```

---

### Block 1858

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'StampLogonText', N'[LOGON]', N'Indica o texto impresso da marca de impressão')
```

---

### Block 1859

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (6, N'StampLogonType', N'1', N'Indica o tipo da marca de código de rastreio')
```

---

### Block 1860

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (7, N'FilterAppList', N'True', N'Indica a lista de expressões que serão utilizadas na memória de sessão')
```

---

### Block 1861

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (7, N'SessionMemoryEnabled', N'0', N'Indica se a memória da sessão está habilitada')
```

---

### Block 1862

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (7, N'TimerApp', N'60', N'Indica o tempo da memória da sessão (em segundos)')
```

---

### Block 1863

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (8, N'AllowedEmpty', N'0', N'Habilita a seleção de nenhuma conta durante a impressão')
```

---

### Block 1864

```sql
INSERT [dbo].[PoliciesParameters] ([PolicyParameterTypeID], [ParameterName], [ParameterValue], [Description]) VALUES (8, N'DisplayName', N'@@CostAccount.ShortName', N'Indica o nome de exibição das contas')
```

---

### Block 1865

```sql
INSERT [dbo].[CountersUnits] ([CounterUnitID], [Description]) VALUES (1, N'Pgs')
```

---

### Block 1866

```sql
INSERT [dbo].[CountersUnits] ([CounterUnitID], [Description]) VALUES (2, N'm2')
```

---

### Block 1867

```sql
INSERT [dbo].[CountersUnits] ([CounterUnitID], [Description]) VALUES (3, N'ml')
```

---

### Block 1868

```sql
INSERT [dbo].[CubeProcessing] ([ServiceName]) VALUES (N'Waiting                                           ')
```

---

### Block 1869

```sql
INSERT [dbo].[CubeProcessing] ([ServiceName]) VALUES (N'Waiting                                           ')
```

---

### Block 1870

```sql
INSERT [dbo].[CubeProcessing] ([ServiceName]) VALUES (N'Waiting                                           ')
```

---

### Block 1871

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (1, N'QuotasAccounts', 1, NULL, NULL)
```

---

### Block 1872

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (2, N'QuotasManagers', 1, NULL, NULL)
```

---

### Block 1873

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (3, N'ScheduledReports', 1, NULL, NULL)
```

---

### Block 1874

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (11, N'PINCodeAutoRenewExpired', 1, NULL, NULL)
```

---

### Block 1875

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (5, N'PINCode', 1, NULL, NULL)
```

---

### Block 1876

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (6, N'CreatePassword', 1, NULL, NULL)
```

---

### Block 1877

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (12, N'PINCodeAutoRenewNewUsers', 1, NULL, NULL)
```

---

### Block 1878

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (8, N'QuotaAlertManagerPercentage', 1, NULL, NULL)
```

---

### Block 1879

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (9, N'QuotaAlertUserPercentage', 1, NULL, NULL)
```

---

### Block 1880

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (10, N'QuotaAlertResponsiblePercentage', 1, NULL, NULL)
```

---

### Block 1881

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (1, N'QuotasAccounts', 1, NULL, NULL)
```

---

### Block 1882

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (2, N'QuotasManagers', 1, NULL, NULL)
```

---

### Block 1883

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (3, N'ScheduledReports', 1, NULL, NULL)
```

---

### Block 1884

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (11, N'PINCodeAutoRenewExpired', 1, NULL, NULL)
```

---

### Block 1885

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (5, N'PINCode', 1, NULL, NULL)
```

---

### Block 1886

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (6, N'CreatePassword', 1, NULL, NULL)
```

---

### Block 1887

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (12, N'PINCodeAutoRenewNewUsers', 1, NULL, NULL)
```

---

### Block 1888

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (8, N'QuotaAlertManagerPercentage', 1, NULL, NULL)
```

---

### Block 1889

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (9, N'QuotaAlertUserPercentage', 1, NULL, NULL)
```

---

### Block 1890

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (10, N'QuotaAlertResponsiblePercentage', 1, NULL, NULL)
```

---

### Block 1891

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (1, N'QuotasAccounts', 1, NULL, NULL)
```

---

### Block 1892

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (2, N'QuotasManagers', 1, NULL, NULL)
```

---

### Block 1893

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (3, N'ScheduledReports', 1, NULL, NULL)
```

---

### Block 1894

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (11, N'PINCodeAutoRenewExpired', 1, NULL, NULL)
```

---

### Block 1895

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (5, N'PINCode', 1, NULL, NULL)
```

---

### Block 1896

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (6, N'CreatePassword', 1, NULL, NULL)
```

---

### Block 1897

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (12, N'PINCodeAutoRenewNewUsers', 1, NULL, NULL)
```

---

### Block 1898

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (8, N'QuotaAlertManagerPercentage', 1, NULL, NULL)
```

---

### Block 1899

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (9, N'QuotaAlertUserPercentage', 1, NULL, NULL)
```

---

### Block 1900

```sql
INSERT [dbo].[CustomizedEmails] ([CustomizedEmailID], [CustomizedEmailName], [UseDefault], [Subject], [Message]) VALUES (10, N'QuotaAlertResponsiblePercentage', 1, NULL, NULL)
```

---

### Block 1901

```sql
SET IDENTITY_INSERT [dbo].[DriversQualities] ON
```

---

### Block 1902

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (1, N'Lexmark X644e PS3', 600)
```

---

### Block 1903

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (2, N'Lexmark 7000/7200 Color Jetprinter', 300)
```

---

### Block 1904

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (3, N'Lexmark T644', 300)
```

---

### Block 1905

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (4, N'Lexmark 5700 Color Jetprinter', 300)
```

---

### Block 1906

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (5, N'Lexmark 3100 Series', 600)
```

---

### Block 1907

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (6, N'Lexmark 3300 Series', 600)
```

---

### Block 1908

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (7, N'Lexmark 6200 Series', 600)
```

---

### Block 1909

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (8, N'Lexmark 6300 Series', 600)
```

---

### Block 1910

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (9, N'Lexmark Z52 Color Jetprinter', 300)
```

---

### Block 1911

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (10, N'Lexmark C500', 150)
```

---

### Block 1912

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (11, N'HP Color Inkjet CP1700', -2)
```

---

### Block 1913

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (12, N'HP OfficeJet Series 700 Print', 300)
```

---

### Block 1914

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (13, N'HP Business Inkjet 3000 PS', 300)
```

---

### Block 1915

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (14, N'HP Color LaserJet 1600', 600)
```

---

### Block 1916

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (15, N'HP Universal Printing PS', 300)
```

---

### Block 1917

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (16, N'HP Deskjet D730', 300)
```

---

### Block 1918

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (17, N'HP 2000C Printer', -1)
```

---

### Block 1919

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (18, N'HP 2500C Series Printer', -1)
```

---

### Block 1920

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (19, N'Xerox WorkCentre PE16', 300)
```

---

### Block 1921

```sql
INSERT [dbo].[DriversQualities] ([DriverID], [DriverName], [DraftQuality]) VALUES (20, N'Xerox WorkCentre 24 PCL 6', 600)
```

---

### Block 1922

```sql
SET IDENTITY_INSERT [dbo].[DriversQualities] OFF
```

---

### Block 1923

```sql
INSERT [dbo].[InvalidPrinterKeys] ([InvalidData], [IsMac]) VALUES (N'CNPNB02252', 0)
```

---

### Block 1924

```sql
INSERT [dbo].[InvalidPrinterKeys] ([InvalidData], [IsMac]) VALUES (N'PBAi-DPTUSBNo1', 0)
```

---

### Block 1925

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'AccountsPinUniqueIdentifier', N'1')
```

---

### Block 1926

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'AllowUsersSetInitialView', N'1')
```

---

### Block 1927

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'AuthenticatorsPath', N'[AUTHPATH]')
```

---

### Block 1928

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CalcEnvironmentImpactCarbonDioxide', N'0,079025')
```

---

### Block 1929

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CalcEnvironmentImpactEnergy', N'0,02341')
```

---

### Block 1930

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CalcEnvironmentImpactTree', N'7500')
```

---

### Block 1931

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CalcEnvironmentImpactWater', N'0,468')
```

---

### Block 1932

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CleanUpSlotsHistorics', N'1')
```

---

### Block 1933

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ClearPinCodeOnAccountRemove', N'0')
```

---

### Block 1934

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CostAccountsShowCode', N'0')
```

---

### Block 1935

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CostAccountsType', N'1')
```

---

### Block 1936

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CreateServerPort', N'0')
```

---

### Block 1937

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'CurrencySymbol', N'pt-BR')
```

---

### Block 1938

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DataBaseVersion', N'770')
```

---

### Block 1939

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DataBaseVersion360', N'1000')
```

---

### Block 1940

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DefaultEngagedVolume', N'0')
```

---

### Block 1941

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DefaultPrinterCostExtra', N'0')
```

---

### Block 1942

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DefaultPrinterCostFixed', N'0')
```

---

### Block 1943

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DefaultPrinterProductivity', N'0')
```

---

### Block 1944

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DefaultTrustOriginRule', N'2')
```

---

### Block 1945

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DpoEmail', N'')
```

---

### Block 1946

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DpoEnabled', N'0')
```

---

### Block 1947

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DpoName', N'')
```

---

### Block 1948

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'DpoPhoneNumber', N'')
```

---

### Block 1949

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'EventsDateExecuted', N'2013-01-01')
```

---

### Block 1950

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'EventsStatus', N'4')
```

---

### Block 1951

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ForcedTransaction', N'0')
```

---

### Block 1952

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'GetPrinterDeviceIDDisableConditionalCheck1', N'0')
```

---

### Block 1953

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'HideCubeReports', N'0')
```

---

### Block 1954

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'HideReports', N'0')
```

---

### Block 1955

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'Integration360Enabled', N'0')
```

---

### Block 1956

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'Integration360IdentityClientId', N'')
```

---

### Block 1957

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'Integration360IdentitySecretKey', N'')
```

---

### Block 1958

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'IntegrationPrintJobsEnabled', N'0')
```

---

### Block 1959

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'IntegrationPrintJobsIdentityClientId', N'')
```

---

### Block 1960

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'IntegrationPrintJobsIdentitySecretKey', N'')
```

---

### Block 1961

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'IsAuditPrintJobs', N'0')
```

---

### Block 1962

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'IsProfessionalVersion', N'0')
```

---

### Block 1963

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'LastDateSuppliesClean', N'2010-1-1 00:00:00')
```

---

### Block 1964

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'LicensingAlertsEnabled', N'0')
```

---

### Block 1965

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'LicensingAlertsInChargeEmail', N'')
```

---

### Block 1966

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'LocalDomainsName', N'Estações Locais')
```

---

### Block 1967

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'MaxResultExportAll', N'500000')
```

---

### Block 1968

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'n-ControlGeneralLic', N'1')
```

---

### Block 1969

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'n-ControlPrintLic', N'1')
```

---

### Block 1970

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_LogisticStatistics_Actived', N'0')
```

---

### Block 1971

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_LogisticStatistics_Responsible', N'')
```

---

### Block 1972

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_LogisticWarning_Actived', N'0')
```

---

### Block 1973

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_PAOffLine_Actived', N'0')
```

---

### Block 1974

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_PAOffLine_Responsible', N'')
```

---

### Block 1975

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_QuotasExpire_Actived', N'0')
```

---

### Block 1976

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_QuotasExpire_Responsible', N'')
```

---

### Block 1977

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_SMTPServer', N'127.0.0.1')
```

---

### Block 1978

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_WarningJobs_Actived', N'0')
```

---

### Block 1979

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NA_WarningJobs_Responsible', N'')
```

---

### Block 1980

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBEnterprisesPendents', N'0')
```

---

### Block 1981

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBEnterprisesPendentsQuotas', N'0')
```

---

### Block 1982

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBExecutedToday', N'0')
```

---

### Block 1983

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBLastExecutionModule', N'2024/02/01')
```

---

### Block 1984

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBLastExecutionQuotas', N'2001-01-01')
```

---

### Block 1985

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBNotificationTime', N'06:00')
```

---

### Block 1986

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'NBNotificationTimeQuotas', N'00:00:01')
```

---

### Block 1987

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'nClientInactiveDays', N'3')
```

---

### Block 1988

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'PrintersDevicesGroupsType', N'2')
```

---

### Block 1989

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'QuotasDateExecuted', N'')
```

---

### Block 1990

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'QuotasStatus', N'4')
```

---

### Block 1991

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ReleaserStorageQuotaAllowed', N'52428800')
```

---

### Block 1992

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ReleaserStorageQuotaEnabled', N'0')
```

---

### Block 1993

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ReportDigitizingSumPages', N'1')
```

---

### Block 1994

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SAPIntegratorRules', N'')
```

---

### Block 1995

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SaveTonerBehaviorEnabled', N'0')
```

---

### Block 1996

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SaveTonerBehaviorEnabledDate', N'')
```

---

### Block 1997

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SaveTonerDefaultRuleEnabled', N'0')
```

---

### Block 1998

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SaveTonerDefaultRuleSavingPercentage', N'1')
```

---

### Block 1999

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SaveTonerLicensingEnabled', N'0')
```

---

### Block 2000

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ScanFlowEnabled', N'0')
```

---

### Block 2001

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SendToUserQuotaNotification', N'0')
```

---

### Block 2002

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SettingsUserAnonymizationPeriod', N'-1')
```

---

### Block 2003

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ShowCostsReportsToAccounts', N'1')
```

---

### Block 2004

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ShowCostsReportsToManagers', N'1')
```

---

### Block 2005

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'ShowCountersOnWeb', N'1')
```

---

### Block 2006

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'SuppliesTypesFilter', N'')
```

---

### Block 2007

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'TimeWorkAfternoonBegin', N'12:00')
```

---

### Block 2008

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'TimeWorkAfternoonEnd', N'18:00')
```

---

### Block 2009

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'TimeWorkMorningBegin', N'08:00')
```

---

### Block 2010

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'TimeWorkMorningEnd', N'12:00')
```

---

### Block 2011

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UpdatePrintersDevicesTrustOriginv532', N'1')
```

---

### Block 2012

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UseProductionAsReferenceCounter', N'0')
```

---

### Block 2013

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UserCanChangePIN', N'0')
```

---

### Block 2014

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UserPINExpirationDays', N'0')
```

---

### Block 2015

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UserPINReuseCycle', N'0')
```

---

### Block 2016

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UserPINType', N'0')
```

---

### Block 2017

```sql
INSERT [dbo].[Parameters] ([ParameterName], [ParameterValue]) VALUES (N'UserPINMinimumLength', N'0')
```

---

### Block 2018

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (1, N'AccountID', 0)
```

---

### Block 2019

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (2, N'DomainID', 0)
```

---

### Block 2020

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (3, N'CostAccountID', 0)
```

---

### Block 2021

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (4, N'AccountGroupID', 0)
```

---

### Block 2022

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (5, N'PrinterDeviceID', 0)
```

---

### Block 2023

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (6, N'PrinterQueueID', 0)
```

---

### Block 2024

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (7, N'MachineID', 0)
```

---

### Block 2025

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (8, N'CostGroupID', 1)
```

---

### Block 2026

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (9, N'PortID', 2)
```

---

### Block 2027

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (10, N'ApplicationID', 2)
```

---

### Block 2028

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (11, N'PrintQualityID', 1)
```

---

### Block 2029

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (12, N'PolicyID', 0)
```

---

### Block 2030

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (13, N'PolicyFeatureParameterID', 0)
```

---

### Block 2031

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (14, N'PolicyMemberID', 0)
```

---

### Block 2032

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (15, N'PolicyMessageID', 0)
```

---

### Block 2033

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (16, N'PolicyBehaviorParameterID', 0)
```

---

### Block 2034

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (17, N'PolicyParameterID', 1)
```

---

### Block 2035

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (18, N'AccountAliaseID', 0)
```

---

### Block 2036

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (19, N'PrinterDeviceConsolidationID', 0)
```

---

### Block 2037

```sql
INSERT [dbo].[PoliciesControls] ([PolicyControlID], [PolicyControlName], [PolicyControlNumber]) VALUES (20, N'DriverQualityID', 1)
```

---

### Block 2038

```sql
SET IDENTITY_INSERT [dbo].[PrintersDevicesBillingRules] ON
```

---

### Block 2039

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (1, N'?:\*', N'Local Port', 1)
```

---

### Block 2040

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (2, N'SHRFAX:', N'Microsoft Shared Fax Driver', 1)
```

---

### Block 2041

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (3, N'Fax Lexmark 5400 Series', N'Fax Lexmark 5400 Series Printer', 1)
```

---

### Block 2042

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (4, N'MSFAX:', N'Windows NT Fax Driver', 1)
```

---

### Block 2043

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (5, N'SmarThruFaxPort', N'Samsung SmarThru Fax', 1)
```

---

### Block 2044

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (6, N'LexmarkFax', N'Lexmark Print-2 Fax Printer', 1)
```

---

### Block 2045

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (7, N'NovoFaxPrinterPort', N'NovoFaxPrinterDriver', 1)
```

---

### Block 2046

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (8, N'NUL:', N'CAPTURE FAX', 1)
```

---

### Block 2047

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (9, N'Olffaxdrv', N'OLFModem', 1)
```

---

### Block 2048

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (10, N'V3fax:', N'V3 CallCenter Printer Driver', 1)
```

---

### Block 2049

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (11, N'Microsoft Document Imaging Writer Port:', N'Microsoft Office Document Image Writer Driver', 1)
```

---

### Block 2050

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (12, N'XPSPort:', N'Microsoft XPS Document Writer', 1)
```

---

### Block 2051

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (13, N'IcePortER:', N'Smart Print Capture Driver', 1)
```

---

### Block 2052

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (14, N'Send To Microsoft OneNote Port:', N'Send To Microsoft OneNote Driver', 1)
```

---

### Block 2053

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (15, N'OnBase Local Port', N'Hyland Software Printer', 1)
```

---

### Block 2054

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (16, N'Gnostice Print2eDoc Port', N'Gnostice Print2eDoc', 1)
```

---

### Block 2055

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (17, N'DDM:', N'deskPDF', 1)
```

---

### Block 2056

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (18, N'CutePDF Writer', N'CutePDF Writer', 1)
```

---

### Block 2057

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (19, N'PageManager PDF Writer', N'PageManager PDF Writer', 1)
```

---

### Block 2058

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (20, N'PrimoPDF', N'PrimoPDF', 1)
```

---

### Block 2059

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (21, N'SolidPDFConverter', N'SolidPDFConverter', 1)
```

---

### Block 2060

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (22, N'Adobe PDF Converter', N'Adobe PDF Converter', 1)
```

---

### Block 2061

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (23, N'ZDesigner', N'ZDesigner Driver', 2)
```

---

### Block 2062

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (24, N'Generic', N'Generic Driver', 2)
```

---

### Block 2063

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (25, N'UB-E02', N'E02 Driver', 2)
```

---

### Block 2064

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (26, N'UB-E03', N'E03 Driver', 2)
```

---

### Block 2065

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (27, N'UB-E04', N'E04 Driver', 2)
```

---

### Block 2066

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (28, N'Zebra', N'Zebra Driver', 2)
```

---

### Block 2067

```sql
INSERT [dbo].[PrintersDevicesBillingRules] ([BillingRuleID], [BillingRule], [Description], [BillingRuleTypeID]) VALUES (29, N'PDF', N'PDF Converters', 2)
```

---

### Block 2068

```sql
SET IDENTITY_INSERT [dbo].[PrintersDevicesBillingRules] OFF
```

---

### Block 2069

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (1, N'QuotasType', N'1')
```

---

### Block 2070

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (2, N'QuotasState', N'0')
```

---

### Block 2071

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (3, N'SharedQuotas', N'0')
```

---

### Block 2072

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (4, N'DiscountQuotasFromCopies', N'0')
```

---

### Block 2073

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (5, N'ShowIdentifyQuota', N'0')
```

---

### Block 2074

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (6, N'SendQuotasAlertResponsible', N'0')
```

---

### Block 2075

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (7, N'SendQuotasAlertResponsibleValue', N'10')
```

---

### Block 2076

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (8, N'SendQuotasAlertResponsibleEmail', N'')
```

---

### Block 2077

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (9, N'SendQuotasAlertManagers', N'0')
```

---

### Block 2078

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (10, N'SendQuotasAlertManagersValue', N'10')
```

---

### Block 2079

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (11, N'SendQuotasAlertAccounts', N'0')
```

---

### Block 2080

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (12, N'SendQuotasAlertAccountsValue', N'10')
```

---

### Block 2081

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (13, N'SendQuotasAlertEmailRealTime', N'0')
```

---

### Block 2082

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (14, N'QuotasPopupWarning', N'0')
```

---

### Block 2083

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (15, N'QuotasPopupWarningValue', N'10')
```

---

### Block 2084

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (16, N'QuotasPopupWarningMessage', N'@@QuotasPopupWarningMessage')
```

---

### Block 2085

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (17, N'SendQuotasAlertEmailWarningMessage', N'@@QuotasAlertEmailWarningMessage')
```

---

### Block 2086

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (18, N'SendQuotasAlertEmailBlockedMessage', N'@@QuotasAlertEmailBlockedMessage')
```

---

### Block 2087

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (19, N'ShowQuotaPrepaidCard', N'0')
```

---

### Block 2088

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (20, N'ProcessQuotasLastDate', N'2013-01-01')
```

---

### Block 2089

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (21, N'AllowAddPrepaidCard', N'0')
```

---

### Block 2090

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (22, N'IsCorporativePrepaidCard', N'1')
```

---

### Block 2091

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (23, N'QuotasPaymentsConfigEnabled', N'0')
```

---

### Block 2092

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (24, N'QuotasPaymentsConfigApi', N'https://pay.nddprint.com/quotas/')
```

---

### Block 2093

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (25, N'QuotasPaymentsConfigPagSeguroEmail', N'')
```

---

### Block 2094

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (26, N'QuotasPaymentsConfigPagSeguroToken', N'')
```

---

### Block 2095

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (27, N'QuotasPaymentsConfigPagSeguroUseSandBox', N'False')
```

---

### Block 2096

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (28, N'QuotasPaymentsConfigPagSeguroCheckoutUrl', N'https://pagseguro.uol.com.br/v2/checkout/payment.html?code=')
```

---

### Block 2097

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (29, N'QuotasPaymentsConfigPagSeguroAmounts', N'10.00')
```

---

### Block 2098

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (30, N'QuotasPaymentsConfigPagSeguroIsCorporativeCredit', N'1')
```

---

### Block 2099

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (31, N'QuotasPaymentsConfigPagSeguroFee', N'0')
```

---

### Block 2100

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (32, N'QuotasPaymentsConfigPagSeguroFeeDescription', N'@@ConfigPagSeguroFeeDescription')
```

---

### Block 2101

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (33, N'QuotasPaymentsConfigPagSeguroDescription', N'@@ConfigPagSeguroDescription')
```

---

### Block 2102

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (34, N'UseStandardsQuotaSettingsForManagers', N'0')
```

---

### Block 2103

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (35, N'QuotasObjectType', N'1')
```

---

### Block 2104

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (36, N'ProcessPrintersQuotasLastDate', N'2018-12-18')
```

---

### Block 2105

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (37, N'AlertResponsiblePercentage', N'50¬25¬5')
```

---

### Block 2106

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (38, N'AlertManagerPercentage', N'50¬25¬5')
```

---

### Block 2107

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (39, N'AlertUserPercentage', N'50¬25¬5')
```

---

### Block 2108

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (40, N'AlertResponsiblePercentageEmail', N'')
```

---

### Block 2109

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (41, N'AlertResponsiblePercentageEnabled', N'0')
```

---

### Block 2110

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (42, N'AlertManagerPercentageEnabled', N'0')
```

---

### Block 2111

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (43, N'AlertUserPercentageEnabled', N'0')
```

---

### Block 2112

```sql
INSERT [dbo].[QuotasParameters] ([QuotaParameterID], [QuotaParameterName], [QuotaParameterValue]) VALUES (44, N'AlertPercentageMaxLimit', N'3')
```

---

### Block 2113

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1027, N'Catalan', N'Català (Espanya)', N'ca-ES', N'EUR', N'€', 1)
```

---

### Block 2114

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1031, N'Germany', N'Deutsch (Deutschland)', N'de-DE', N'EUR', N'€', 0)
```

---

### Block 2115

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1033, N'United States', N'English (United States)', N'en-US', N'USD', N'$', 1)
```

---

### Block 2116

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1034, N'Spain', N'Español (España, Alfabetización Internacional)', N'es-ES', N'EUR', N'€', 1)
```

---

### Block 2117

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1036, N'France', N'Français (France)', N'fr-FR', N'EUR', N'€', 0)
```

---

### Block 2118

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1040, N'Italy', N'Italiano (Italia)', N'it-IT', N'EUR', N'€', 0)
```

---

### Block 2119

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (1046, N'Brazil', N'Português (Brasil)', N'pt-BR', N'BRL', N'R$', 1)
```

---

### Block 2120

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (2057, N'United Kingdom', N'English (United Kingdom)', N'en-GB', N'GBP', N'£', 0)
```

---

### Block 2121

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (2058, N'Mexico', N'Español (México)', N'es-MX', N'MXN', N'$', 0)
```

---

### Block 2122

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (2070, N'Portugal', N'Português (Portugal)', N'pt-PT', N'EUR', N'€', 0)
```

---

### Block 2123

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (4096, N'Angola', N'Português (Angola)', N'pt-AO', N'AOA', N'Kz', 0)
```

---

### Block 2124

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (4105, N'Canada', N'English (Canada)', N'en-CA', N'CAD', N'$', 0)
```

---

### Block 2125

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (4106, N'Guatemala', N'Español (Guatemala)', N'es-GT', N'GTQ', N'Q', 0)
```

---

### Block 2126

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (5130, N'Costa Rica', N'Español (Costa Rica)', N'es-CR', N'CRC', N'¢', 0)
```

---

### Block 2127

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (7177, N'South Africa', N'English (South Africa)', N'en-ZA', N'ZAR', N'R', 0)
```

---

### Block 2128

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (7178, N'Dominican Republic', N'Español (República Dominicana)', N'es-DO', N'DOP', N'RD$', 0)
```

---

### Block 2129

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (9226, N'Colombia', N'Español (Colombia)', N'es-CO', N'COP', N'$', 0)
```

---

### Block 2130

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (10250, N'Peru', N'Español (Perú)', N'es-PE', N'PEN', N'S/', 0)
```

---

### Block 2131

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (11274, N'Argentina', N'Español (Argentina)', N'es-AR', N'ARS', N'$', 0)
```

---

### Block 2132

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (12298, N'Ecuador', N'Español (Ecuador)', N'es-EC', N'ECS', N'$', 0)
```

---

### Block 2133

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (13322, N'Chile', N'Español (Chile)', N'es-CL', N'CLP', N'$', 0)
```

---

### Block 2134

```sql
INSERT [dbo].[RegionalSettings] ([CultureID], [EnglishName], [NativeName], [CultureName], [CurrencyName], [CurrencySymbol], [TranslationEnabled]) VALUES (19466, N'Nicaragua', N'Español (Nicaragua)', N'es-NI', N'NIO', N'C$', 0)
```

---

### Block 2135

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (1, N'AccountID', NULL)
```

---

### Block 2136

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (2, N'Classify', NULL)
```

---

### Block 2137

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (3, N'ComputerID', NULL)
```

---

### Block 2138

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (4, N'CostCenterID', NULL)
```

---

### Block 2139

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (5, N'DeviceID', NULL)
```

---

### Block 2140

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (6, N'Exceded', NULL)
```

---

### Block 2141

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (7, N'FilterDescription', NULL)
```

---

### Block 2142

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (8, N'InventoryType', NULL)
```

---

### Block 2143

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (9, N'JobOriginID', NULL)
```

---

### Block 2144

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (10, N'LastDate', NULL)
```

---

### Block 2145

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (11, N'MONTH', NULL)
```

---

### Block 2146

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (12, N'OrderBy', NULL)
```

---

### Block 2147

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (13, N'PaperSizeID', NULL)
```

---

### Block 2148

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (14, N'PrintApplicationID', NULL)
```

---

### Block 2149

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (15, N'PrintColorID', NULL)
```

---

### Block 2150

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (16, N'PrintJobsFilterExists', NULL)
```

---

### Block 2151

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (17, N'PrintWayID', NULL)
```

---

### Block 2152

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (18, N'QueueID', NULL)
```

---

### Block 2153

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (19, N'ReportType', NULL)
```

---

### Block 2154

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (20, N'Unactived', NULL)
```

---

### Block 2155

```sql
INSERT [dbo].[ReportFilterTypes] ([ReportFilterTypeID], [ReportFilterKey], [ReportFilterDescription]) VALUES (21, N'YEAR', NULL)
```

---

### Block 2156

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (1, N'ExpiredLicenses', N'Licenças expiradas', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 1)
```

---

### Block 2157

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (2, N'TrialLicenses', N'Licenciamento trial', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 0)
```

---

### Block 2158

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (3, N'ExpiredQuota', N'Cotas ultrapassadas', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 2)
```

---

### Block 2159

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (4, N'InactiveClients', N'Produtos inativos', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 3)
```

---

### Block 2160

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (5, N'ReportsSchedules', N'Agendamento de relatórios', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 5)
```

---

### Block 2161

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (6, N'QuotasProcessCredits', N'Processamento dos créditos recorrentes', CAST(N'2013-01-01T00:00:00.000' AS DateTime), 0, N'', 6)
```

---

### Block 2162

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (7, N'AnonymizeUsers', N'Anonimização dos usuários removidos', CAST(N'2024-02-01T13:16:08.200' AS DateTime), 4, N'', 4)
```

---

### Block 2163

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (8, N'GenerateAutoPinExpired', N'Processo para gerar pin automaticamente', CAST(N'2022-04-19T00:00:00.000' AS DateTime), 4, N'', 8)
```

---

### Block 2164

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (9, N'ReusableAutoPin', N'Processo para reutilizar pins', CAST(N'2022-04-19T00:00:00.000' AS DateTime), 4, N'', 7)
```

---

### Block 2165

```sql
INSERT [dbo].[TransactionEventsStatus] ([TransactionEventID], [TransactionEventName], [TransactionEventDescription], [LastDateExecuted], [TransactionStatus], [ErrorDescription], [OrderToExecute]) VALUES (10, N'GenerateAutoPinNotHavePin', N'Processo para gerar pins novos automaticamente', CAST(N'2022-04-19T00:00:00.000' AS DateTime), 4, N'', 9)
```

---

### Block 2166

```sql

-- ========================================
-- From Create360AdminUser Method
-- ========================================
SET IDENTITY_INSERT [dbo].[DomainAccessSettings] ON 
GO
INSERT [dbo].[DomainAccessSettings] ([DomainAccessSettingsID], [DomainAccessSettingsAdvancedID], [AccessType], [AuthenticationType], [Enabled]) VALUES (1, NULL, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[DomainAccessSettings] OFF
GO 
SET IDENTITY_INSERT [dbo].[Domains] ON 
GO
INSERT [dbo].[Domains] ([DomainID], [DomainName], [DomainTypeID], [DomainAccessSettingsID], [IsDefault],[DomainGuidId]) VALUES (1, N'nddPrint', 4, 1, 0, NEWID())
GO
SET IDENTITY_INSERT [dbo].[Domains] OFF
GO
 
SET IDENTITY_INSERT [dbo].[Accounts] ON
GO
INSERT [dbo].[Accounts] ([AccountID], [DomainID], [LogonName], [FullName], [Removed], [Email], [CostAccountID], [ChangedDate],[AccountGuidId]) VALUES (1, 1, N'Admin', N'Admin', 0, N'roger.liz@ndd.tech', NULL, CAST(N'2024-03-19T19:50:03.1946813' AS DateTime2), NEWID())
GO
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
```

---

