.class public Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;
.super Ljava/lang/Object;
.source "AVProMobileWMImage.java"


# static fields
.field public static m_aCompressedImage:[I

.field public static m_aCompressedImage_TrailingBytes:[B

.field private static s_aCompressedHash:[B

.field public static s_aImageData:[B

.field private static s_aUncompressedHash:[B

.field public static s_bImagePrepared:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/16 v1, 0x10

    .line 28
    const/4 v0, 0x0

    sput-boolean v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_bImagePrepared:Z

    .line 31
    new-array v0, v1, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aCompressedHash:[B

    .line 32
    new-array v0, v1, [B

    fill-array-data v0, :array_1

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aUncompressedHash:[B

    .line 211
    const/16 v0, 0x8e3

    new-array v0, v0, [I

    fill-array-data v0, :array_2

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage:[I

    .line 213
    const/4 v0, 0x3

    new-array v0, v0, [B

    fill-array-data v0, :array_3

    sput-object v0, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage_TrailingBytes:[B

    return-void

    .line 31
    nop

    :array_0
    .array-data 1
        -0x76t
        -0x6et
        -0x6t
        -0x26t
        -0x15t
        -0x2bt
        -0x3ct
        0x2ct
        -0x6ft
        0x36t
        0x69t
        0x46t
        -0x30t
        -0x42t
        -0x80t
        0x51t
    .end array-data

    .line 32
    :array_1
    .array-data 1
        -0x3ft
        -0x23t
        -0x67t
        -0x4dt
        0x7t
        -0xct
        0x3at
        -0x22t
        -0x7ct
        0x73t
        0x2bt
        0x13t
        -0xbt
        -0x34t
        0x47t
        -0x17t
    .end array-data

    .line 211
    :array_2
    .array-data 4
        0x789ced9d
        0x9784c57
        -0x3878e9
        -0x2a41452d
        -0x82a69ee
        0x5b127b2d
        0x49ed94da    # 1946267.2f
        0x4b15ff96    # 9830294.0f
        0x2e12a44a
        -0x56dadbcd
        0x59865715
        0x415f3bb1
        0x2f5532d9
        -0x6ff74d11
        -0x149bbeb6
        -0x3a255f83
        -0x6eb389af
        0x1abfffb9
        0x33b9c99d
        -0x36d30822
        -0x460861e7
        0x73bfcff3
        0x7d26d5b9
        -0x18618412    # -1.49684E24f
        -0x6630cc5
        -0x3442fd00    # -2.4774144E7f
        0x12102d5a
        -0x4b32a698
        0xdda1964
        0x3764b762
        -0x161f2276
        0x5343fc03
        0x6ea0bfff
        0x1ae2af00
        -0x3d7c02fd
        -0x752f98fa
        -0xd891b71
        0x1d158a66
        -0x7d98af6c
        0x28164224
        0x352a72f0
        0x712a76f0
        0x5a59e4e8
        0x1551ec28
        0x2b409fa5
        -0x3a71a11b
        -0x170cbe6f
        -0x5cd35838
        -0x3e14a74f
        -0x429331fd
        0x7b596b6c
        -0x6eb6705
        -0x3e84b174
        0x465cc791
        -0x732c0d92
        0x45f1a4a3
        -0x58b031aa
        -0x6314d7a8
        0x46458962
        -0x5f3d8869
        -0x43072f2f
        0x6b419183
        -0x13c59de4
        -0x17e74aff
        0x35a82d08
        0x57394807
        0xb9d5fa1
        -0x47e01751
        0x683bd85f
        0x718611ef
        0x3afe704f
        -0x1f4c66d9
        0x228ec801
        0x1af39e61
        0x51a2684a
        0x3570ed57
        0x45dd7d1e
        -0x2f1aa251
        0x1d64810f
        -0x443720ea
        0x2acf4270
        0x3f74b762
        0xce25665
        0xef3544f
        0x397a5ae5
        0x13993a94
        -0x28b374ee
        0x6542158b
        0x7ef9976a
        -0x1bb95aa7
        -0x43940a01
        0x5e0f50cc
        0x304288bc    # 7.07711E-10f
        -0xc320220
        0x3d8a9928
        -0x518035eb
        -0xc5bd8e3
        0x39053fc4
        -0x5b0043c7
        0x3aed5fbc
        0x655e9428
        0x3dba2f57
        -0x4b570ff6
        0x5ea91ae5
        -0x87bd41a
        -0x14278810
        0x7a52e4e8
        0x3d95ef6b
        -0x1f6c04df
        -0x44b1731d
        -0x7c862d61
        0x1c3d0deb
        -0x1d4d3504
        0x12948be5
        0x71714d78
        -0x46f7ae5e    # -1.3000381E-4f
        0x6a057245
        -0x4cf58638
        0x7795f290
        -0x6a7103
        -0x76ac21e5
        -0x4f90d0e3
        -0x3a144a10
        -0x3b022fa3
        -0x3824f222
        0x1d50c217
        -0xc5b98fb
        -0x6178f2f7
        0x4ad810af    # 7080023.5f
        -0x33b8607e    # -5.2329992E7f
        -0x3bb75d94
        0x4b209737    # 1.0524471E7f
        -0x510ff262
        0x59e11b7a
        -0x5cade1f6
        0x6533fd79
        0x639ec2be
        0x4ae5e8d1    # 7533672.5f
        -0x6948941e
        -0x7604de02
        0x1e7f966
        -0x614b0ba4
        -0x4d798273
        0x151b1332
        -0x248f81bf
        -0x5d93ad6b
        0x3e21632b
        -0x1b5e86fc
        -0x107bd424
        0x4f407177
        0x1fdeb9af
        -0x6210c03d
        -0x288a0e3f
        0x7ded3c9e
        0x20cc139e
        0x78f81495
        0x7bf08b57
        0x3ef28bcf
        -0xdbd4e81
        0x734e2f4c
        -0x6b3257b6
        0x1eec8c38
        -0x70d886d9
        0x5d327a93
        0x20cc533c
        -0x7970141d
        -0x7c843b9e
        -0x4d6f23ed
        0x5e1191a4
        -0x3a81d201
        0x3736c467
        0x4fe4f4e2
        0x2c5971d0
        0x44125cf2
        -0x41db4f08
        0x7349b06a
        -0x41db470c
        0x1b4950c9
        -0x586d6fde
        0x774931b
        -0x1e3161cb
        -0x57a3812e
        -0x4e3dc8dc
        0x54977775
        0x5fbff4b8
        -0x2f335c88
        0x5f96c4c7
        0x7572cdfd
        -0x5fc238c5
        0xbcd3ce1
        -0x3071b8cc
        -0x1f417101
        0x465c4fa
        -0x763b164
        0x5da4a529
        -0x4737e60f
        0x7e14b90c
        0x19f43a48
        0x751f7d6e
        -0x6cd7b53b
        -0x42b0850c
        -0x37d44bb3
        -0x7ac31c00
        -0x7516002a
        -0x38c31e2e
        0x29db04e7
        -0x610ffc85
        -0x3031a3a1
        0x2fd7dc0f
        -0x26e21f7f    # -2.777401E15f
        -0x7c041e85
        0x351ff9e
        0x6590fd0d
        -0xea680df
        -0x12892c8
        -0x6008b032
        0x2e16b782
        -0x7421ba03
        -0x6b67c54
        -0x141800e7
        0x3a6697e4
        -0x1b3c688f
        0x67df1254
        -0x19e60d9a
        -0x5ac39b9d
        -0x7a90974b
        0x21de49ab
        -0x63a99c1f
        -0x41273e95
        0x5d7d7cd
        0x35f78377
        0x744e0e0
        -0x614fb385
        0x7ecf10ff
        -0x8c9db9a
        0x7e06d61e
        -0x8f96874
        0x400c1731
        0x625e9bff
        -0x146d5f79
        -0x947d0fd
        -0x689f2607
        0x7f56fa86
        0x78219e4b
        0x4df1ae8e    # 5.06843584E8f
        -0xec2eb88
        -0x6788ab11
        -0x18761f04
        -0x5461802
        0x362eee17
        -0x6171cc33
        0x7dddd83f
        0x2bc12f31
        -0x44f898e9
        0x2ea4828b
        -0x385f0e05
        0x13d6ccd7
        -0x4c00afee
        0x58dc15f7
        -0x1af7d690
        -0xc90a5d2
        0xf9d8ffa
        -0x8c01610
        0x4ebafcdb
        0x2318b997
        -0x221943e4
        -0x47700c61
        -0x1e1d8192
        0x70146dee
        0x6bc7fd7f
        -0x43ad449
        -0x52b24508
        0x3a6705c0
        -0x4877c1c6
        -0x475b2d94
        -0x191402c5
        0x1af3bf81
        -0x44d07ea
        -0x551a72f0
        -0x140078e8
        -0x41317b89
        -0x2d9aa011
        -0x3c3682f3
        -0x181a3edf
        -0x88203b1
        -0x407b7487
        -0x3dd11be2
        0x1ea68ecf
        0x7ae017a7
        -0x63940e31
        -0x4d71fe1
        -0x5770a98e
        -0x37c3169d
        -0x47d072b1
        -0x5e0e04b9
        0x15f2901c
        0x36bcd771
        0x2fc05e1d
        0x63bed747
        -0x1ed689b
        -0x3d968071
        -0x3933c747
        -0x60e23b54
        -0x40901754
        -0x53f276b6
        0x276e0a83
        0x70595cc
        -0x1d7e8673
        0x3cb2cf7
        -0x45a655b6
        0x1ed21f31
        0x1f6b0eef
        0x75dc7fb5
        0x172bf7c4
        0x73fd5c96
        0xde7e37b
        0x7f45292e
        -0x1140f273
        -0x2e340c56
        -0x7d307ce
        0x32154645
        0x24827378
        -0x7d25dc2f
        -0x20a05f81
        0x5b19d770
        0xdc02f21
        -0x147fbac2
        -0x10eca36e
        -0x30e4083f
        -0x55ec47d1
        -0x70d46a35    # -8.4598E-30f
        -0x7c13d483
        0x4383b9e0
        -0x429183c1
        -0x4ff39c8
        -0x20546b15
        0x32e27e5e
        0x4f91898b
        0x7bf73389
        0x5afc2e89
        0x4987ee61
        0x71d038e8
        0x3c480c98
        -0x7802230
        0x77be47df
        -0x2a260c3d
        -0x320cc1e0
        0x6f2c493d
        -0x241dbd3
        0x6cae2435
        0x6cad2435
        0x7c33f226
        0x497ab83b
        -0x5488e6e
        -0xb77a898
        -0x5aec5516
        -0x31e00c16
        0x39bec792
        -0x2c08c773
        0x25855695
        0x2cec9d0a
        -0x206f423a
        -0x291f2646
        0x62f12ff8
        -0x584f8a7
        0x26d765c5
        -0x643611a
        -0x22a7a748
        0x5f139ba1
        0x66761df2
        0x50d49f37
        0x32c2bb3e
        -0x8ba3854
        0x6b30f657
        -0x195070a9
        0xe675c10
        -0x354c52ef    # -5887624.5f
        -0x2881770b
        0x3f2569e1
        0x60d8614f
        0x513b704a
        -0x6d813908
        0x3345c1aa
        0x45bc728f
        -0x23da4d94
        0x19dbfb8e
        0x53a59ee1
        -0x50dc2903
        -0x17533e4d
        -0x4990f7ec
        -0x80b3a3c
        -0x4228c952
        -0x34730403    # -1.8479098E7f
        0x7a811370
        0x304feed1
        -0xee3a0c
        0x5d4ec732
        -0x1d621581
        -0x6071fc71
        0x4bdb17f
        0xade77d
        -0x7707dfd3
        -0x33f84626    # -3.5579752E7f
        0x38ef7a1d
        0x25c90cb7
        -0x2c649150
        0x6a1fdfdc
        0x778f2ecb
        -0x1a53ddf8
        0x2058a278
        0x11f128a5
        -0x44f99052
        0x4b466dc4    # 1.3004228E7f
        -0x3d4235a2
        0x369ef3b2
        -0x1c6704c2
        -0x101b22f
        0x18ffa1d0
        -0x2330bc9d
        0x7b149743
        0xf14b3b3
        0x659ef4bf
        0x501a5f27
        0x65c3aa86
        0x7d7f15f1
        -0x43306978
        -0x7de80ba2
        0x7c62442b
        -0x3b84cdf5
        -0x2156d191
        -0x6e8e89a6
        -0x7c4b6612
        -0x349c1ea2
        -0x2e9aca0d
        -0xdd5211e
        -0x53cd0fdc
        -0x6f38ca57
        -0x6d7845cf
        0x5d83377b
        -0x73c0b808
        0x313ef10e
        0x1ee8e3d6
        -0x6b0ccd1c
        -0x1e46633f
        -0x1fed47b
        0x64fec3bd
        0x41f0636c
        0x264c3d9f
        0x6c36f3a4
        -0x44ba5940
        -0x3b1be368
        -0x7407a05d
        -0x1886600b
        -0x7635f6a6
        0x174d309f
        0x1a76d54c
        -0x192a917c
        -0x3851987
        0x37adf483
        0x4bcef0cd    # 2.7124122E7f
        0x7d8fe872
        0x70cbaef4
        -0x1f4bcd90
        0x28cd1a7c
        -0x37cb3ba0    # -185105.5f
        -0x7e6f43ad
        0x637d55ff
        -0xf73343
        0x4cce4b59    # 1.0815764E8f
        -0xd0ee312
        -0x3e2f287a
        -0x13a9c3f0
        -0x75849d41
        -0x31f0d742
        0x7f292492
        0x33ee9b04
        0x47c2e8c4
        0x6c9880d8
        -0x607b4400
        -0xe209f14
        -0x605fc35d
        0x7ede275f
        -0x2ef30e66
        -0x36fa0c5c    # -548666.25f
        0x1ba7863d
        -0x146bec09
        0x795da106
        -0x6ae31865
        -0x4814e96
        -0x1190a51e
        0x3e860af9
        -0x366e97f4    # -1191169.5f
        -0x503b3dc5
        -0x4a308827
        0x2fe0b85e
        0x765f65e7
        -0xed5e01b
        -0x362884c9
        -0x770815f7
        -0x3e03477d
        -0x5e4fe1cf
        0x3fe51c77
        0x7d3de9ae
        -0x5730d848
        0x273d0579
        0x296a0bfc
        0x749ef7e9
        -0x61ed6236
        0x25f3a45b
        0x649cab99
        0x7e3567a4    # 6.02821E37f
        -0x45bf7cb5
        0x56f1cdfd
        -0x375bf590    # -335955.5f
        -0x3456fd49    # -2.2152558E7f
        -0x233570c8
        -0x50efd3ab
        0x253fd9b7
        0x521e128d
        -0x6488528f
        -0x10f0a3e
        0x706f2ffd
        -0x73508d1b
        -0xa028502
        -0x75bc83ce
        0x3f7c4f20
        -0x7bb5956
        -0x6149b3a
        0x5c9e21bf
        -0x762d5b8e
        0x4f7a3ab2
        0x27e29f38
        -0x50b89dfa
        -0x37cf81a
        0x49f7be98    # 2029523.0f
        -0xb0b64e5
        0x17a64a82
        0x4a47f2cd    # 3275955.2f
        -0x23333b6
        0xdf73995
        0x21bc5408
        0x62af30e
        -0x157be7ad
        -0x1f99a361
        -0x76988bac
        0x7d56f21b
        -0x20c48707
        -0xca64184
        0x724ffcce
        -0x321f2276
        0x283e981f
        -0x7967a0e2
        0x51bf5eff
        0x42307731
        0x3ee9c628
        -0x320e8548
        0x273d3329
        0x7faa6c4
        -0xd39c31f
        0x66e911e0
        0x723dafe6
        -0x14940635
        0x24c1aa62
        -0x416780d5
        -0x434b6987
        0x35f77fbb
        0x665709f6
        0x2e77aa2a
        0x65c1ad2b
        0x7c43fdf9
        0x5883e794
        0x7d623d9f
        -0x588ac21e
        -0x2a51fd8
        -0x180ac85e
        -0x781704a
        -0xcd93a75
        -0x772cafb2
        -0x406427f
        0x5aefd721
        -0x91c8e33
        0x3ce95189
        0x4a83dc8f    # 4320839.5f
        0x4bce8626    # 2.7069516E7f
        0x696778e5
        -0x610f7735
        0x69e076f3
        0x22b48bb9
        -0x683ee809
        -0x3cedd4d8
        -0x23542609
        -0x1e52ad18
        0x51893cf4
        0x35c4fb5a
        0x5ed7e079
        0x605fd567
        0x15c7cc7b
        0x5f0cd3c
        0x21417e2f
        0x7a0d160
        0x7f852762
        -0x9764634
        0x4f387412
        -0x1bae96a6
        -0xc94a18f
        -0x66438ec1
        0x2221cb20
        -0x831d697
        -0x43ccb048
        0x636e9c9a
        -0x450f50e
        -0x5eb6970f
        0x5f5c33ff
        0x7a5829cc
        -0x36512d1e
        0x7e6e4e65
        -0x1ecb1dc7
        0x209e55bb
        0x6bf1cb9
        0x437c7ac
        -0x2708f37c
        -0x6dee81e4
        0x302fab2e
        0x72f0fe9e
        -0x148207fa
        -0x34a23f21    # -1.4532831E7f
        -0x38e44d09
        -0x47fc9dc9
        -0x63f2105d
        -0x9fa5409
        -0x20148459
        -0x31e5e105    # -6.464304E8f
        -0x470730c
        -0x8f1d677
        -0x7d8f0096
        -0x19c6ca09
        -0x7bb89ba1
        -0x186b063a
        0x21253039
        -0x52ad5851
        -0x508a89ab
        -0x7c88ecaa
        -0x36db02e1
        0x4925dec8    # 679404.5f
        0x2791f3ab
        0x3d2585d5
        0x52c91df4
        -0x89a1bad
        -0x70c3dac2
        0x559e1227
        0x53f59758
        -0x7cb82334
        -0x566f7824
        -0x3a3e1411
        0x4b8e40ee    # 1.8645468E7f
        -0x4b60df96
        -0x57c87b0c
        0x5a0c271c
        0x17c071fb
        -0x6ef2793
        0x219c1de0
        0x96913d7
        -0x3d128605
        0x69a747ec
        -0x20a8c6cd
        0x7f1f0fea
        -0x20605e48
        -0x1bb96a9
        -0x50f1036f
        -0x585803cf
        -0x3e1d11e
        -0x4704ef01
        -0x7f006586
        0x47073186
        -0x600d8ce8
        0x2c3a1d07
        -0x147342bd
        0xbf9e590
        0x28ce996f
        -0x792dcb3c
        0x3ce1b6a9
        -0x37112b7
        0x13ebf924
        -0x87b44db
        0x1672c6fd
        -0x6ffb2208
        0x5ecb61ea
        0x3a229734
        0x437ccf43
        0x4cff8618    # 1.33968064E8f
        0x73a46df
        -0x4271c141
        -0x7a7aed53
        0x3d4ec41a
        0x7cb94fe8
        -0x586a0d70
        -0x207b9943
        -0x27c8e74e
        0x5c764040
        -0x409a8f60
        -0x52d4d2f9
        0x387ea76e
        0x1fcabd83
        0x4d9fc317    # 3.35045344E8f
        -0xe1089f8
        0x4ac66c02    # 6501889.0f
        0x556fb9a9
        0x317c3eea
        -0x1c28c390
        -0xf390d22
        0x475cbf83
        0x4d8af8bd    # 2.9144464E8f
        -0x33de017f    # -4.2465796E7f
        0x63271d3e
        -0x4a25cad0
        0x326f5e48
        -0x331c3a9f
        -0xe1f8ac2
        0x45bd3e47
        -0x8e62522
        -0x17e75147
        0x6f1d1e6f
        -0x6b0488ae
        0x6304e19e
        -0x4f1472f5
        -0x634d20f8
        0x79607cb9
        0x31e6616e
        0x76654dfe
        -0x199ea0a9
        0x7b352da6
        -0x3484fc02    # -1.6450558E7f
        -0x5a6d9418    # -2.5400083E-16f
        0x53fd7c43
        -0x7ac387bc
        -0x7ac3cbad
        0x48d64b7d
        0x43e0b677
        0x642d3d
        0x8a012b
        0x68f3ae6b    # 9.20602E24f
        0x58a036e
        0x31e8ffd5
        0x63806527
        -0x5f331230
        -0x6c2de645
        -0xdb4d893
        0x51a886af
        -0x6c554507
        0xc2d7594
        0x637fcf09
        0x6eee75e5    # 3.689998E28f
        -0x50abc923
        0x1097356c
        0x437cd686
        -0x25203f5f
        -0x3a4294ac
        0x2ae7dcf7
        -0x72b1cc36
        -0x244fd0b
        -0x8ed6202
        -0x610b4f0c
        0x3fa05928
        0x73e65b9c
        0x2a85f129
        0x46fb79b5
        -0x30e2a174
        -0x27923b76
        0x779dbebf
        -0x5935141d
        0x6b42b18e
        -0x25e94715
        -0x5c7fb44e
        0x6390e279
        0x18a2ddb6
        -0x3c6ed10d
        0x58334ffa
        -0x1f844caf
        -0x2040363c
        -0x46bc61ef
        -0x1007afc1
        0x27e4133c
        -0x75674040
        -0x326bc1a7
        0x1af7ba5a
        0x1b97dbce    # 2.51229E-22f
        0x2f4ef9ad
        0x5fbc329c
        -0x7c2f3dd
        -0x10337d81
        -0x60731974
        -0x668aea6
        -0x39290ff8
        0x77488d17
        -0x7b0619e7    # -5.875093E-36f
        0x117ab927
        -0x31a1a65
        -0x2fdc4574
        0x16ff2f9d
        0x2c85feb1
        -0x1a1f6593
        -0x63883d87
        0x3b269acd
        0x7b03febd
        0x27f2cafb
        0x7d9f20b8
        -0x1d8ae32e
        0x3c8f4032
        -0x1d628f0c
        -0x23928f58
        -0x3ca34c67
        -0x58c58c4e
        -0x60c91442    # -3.8735E-20f
        0x21bf57f8
        -0x7911d822
        -0x1caad1ab
        -0x4b3d32f4
        0x1d593af7
        0x5411bf7f
        -0x4cdec18d
        0x2ce27c2b
        0x6a036eea
        -0x4d40dfc6
        -0x620e4c49
        -0x5b35b0f
        0x416c8651
        -0x19f608b6
        0x491184fb
        -0x484c5cf3
        0x72aff6b5
        -0x209f8992
        0x198c49ae
        -0x7fa1ce1b
        -0x2f01a3e7
        -0x4bc1acf6
        0x6f9f2983
        0xee8efbe
        -0x770a7657
        -0x6acf28fc
        -0x147be89a
        0x1541c1f6
        0x519c334f
        -0x45350495
        -0x31381329
        -0x42b1bf5a
        -0xb97e215
        -0x5b1ce813
        -0x7e3c6242
        -0x1e6b862e
        0x39533766
        0x11efe724    # 3.7850003E-28f
        -0x9e81e1a
        -0x7d725377
        0x7b5dad4f
        -0x31134ddf
        0x316b895f
        0x7c5634b1
        0x5f96607f
        0x2207fb75
        0x1dce279b
        0x649ef087
        -0x36a67d90    # -890919.0f
        -0x2018ad6e
        0x71ee09df
        -0x7ea23d2
        0x169be4da
        -0x67826c81
        -0x7a8444ba
        0x40b5ccfc
        -0x27214fe5
        0x4395ef3a
        0x4ec6ecb9
        -0x4d60e450
        0x4ef5f1be
        0x4b78619e    # 1.6277918E7f
        -0xf014952
        -0x6a042547
        -0x417864ff
        -0x494d9912
        -0x56a56064
        -0x30d39bc
        -0x1a9bebf9
        -0x13e2ec6f
        0x54cab6df
        -0x108d71e2
        -0xc5b20b8
        -0x721b6205
        -0x16fa265a
        -0x46a84c81
        0x9dc2edd
        0x67c5fc9e
        -0x37acaf42
        0x6b2054fb
        -0x413bdc0d
        -0x4a0e4154
        0x2de237c8
        -0x53ce44cf
        -0x21f6b884
        -0x1938e40d
        0x756ee38a
        0x7d3f335b
        0x3d2fdceb
        -0x55381648
        0x79cd8322
        0x5574797f
        0x31340a9c
        0x62d21931
        0x4ff87d9e
        0x63fd774d
        -0x3a070584
        -0x6d19222
        -0x18d4b4df
        0x3a68353c
        -0x2121f8e2    # -7.9993946E18f
        0x6fb0e39d
        -0x6458721
        0x6731eb31
        -0x44b684e4
        -0x796044d2
        -0x1f60845e
        -0x2090182e
        0x13775d67
        -0x5c186a85
        -0x4adddda2
        -0x6ffb6165
        -0x24c71744
        -0x2daf0001
        -0x2556e718
        0x1e990263
        -0x6c4d14a8
        0x1e1d9f0a
        0x323c2a0
        -0x1036ec30
        0x2bf830f4
        0xe390afd
        0x4f07c2d0
        -0x37b7e761
        -0x5b427079
        -0x670484d3
        -0xac3d034
        0x13ebf653
        0xa94ccb9
        0x27fcdb2d
        0x70cbae78
        0x668c79cf
        -0x4be4af90
        0x68a68679
        -0x1b9586f5
        -0x3e4780dc
        -0x14379534
        0x4ec7912e    # 1.67409024E9f
        0x5b04615e
        -0x3282e4e9
        -0x31207edb
        -0x7b619412
        0x29ea1b95
        -0x26502407
        -0x1b3222dd
        0x5373fa46
        -0x5ac1e6f0
        -0x64ae0884
        -0x42855083
        0x5216625b
        0x1ed0ead
        -0x7a69c469
        0x1bf45bbb
        -0x5a9f0035
        0xe181659
        -0x40589898
        0x4a0634e6    # 2198841.5f
        0x619f7eaf
        -0x74761368
        0x275d700d
        -0x19196b29
        -0x179c81b5
        0x4c34a876    # 4.7358424E7f
        0xfab63fe
        -0xe69117e
        0x314fbad2
        0x7727e331
        0x3b1d878c
        -0xbee7105
        -0x4951888f
        -0x2892c94e
        0x15eea91a
        0x1a17d77c
        0x7c8a72f4
        -0x75b6361
        0x2624e55c
        0x1b70e614
        -0x4342a892
        -0x6b888212
        0x7c6c0b7c
        0x1497cc4b
        -0x4320d9d9
        0x6e698c3
        0x3ce9eb57
        0x606e6e49    # 6.8723E19f
        0x1dfbf3b2
        0x2b20ece4
        0x7feb7927
        -0x1228b190
        -0x1154831a
        0x311ab3d3
        -0xa4e6175
        0x4e39ef0
        -0x3e084192
        -0x7844b1cd
        -0x6ad28da1
        0x27c5b47f
        -0x4b231642
        -0x7cd610ac
        -0x4809087e
        0x21e7ceaa
        -0x2610666e
        -0x53713247
        0x605e777f
        -0x61a6416f
        0xf6e171e
        0x3e73cfb8
        0x3978ece
        0x69c83c11
        -0x1c5086b5
        0x70eeef4a
        -0x788c39c6
        -0x2af82431
        0x1194fb7d
        0x6d5d397f
        -0x10da204e
        0x59ee11f3
        0x6fee740f
        0x3487f9ba
        -0x278028f6
        0x187fe638
        0x4c4d4a83    # 5.381582E7f
        0xf52d2a1
        0x79da59d6
        -0x1c0621d8
        -0x496034eb
        -0x10eb50a9
        0x6c1833d
        -0x5c0bcd51
        -0x19812a95
        -0x7d8c80a1
        -0x25728c1a
        0x1397ed17
        -0x6b86ca09
        0x6d5c67e1
        -0x5131b39b
        -0x5423dc1a
        0x3773c13c
        -0x1680120e
        0x97f347
        0x6061c229
        -0x6766e7fd
        -0x9d64e30
        0x242d8236
        -0xc92aee1
        -0xd624c7
        0x3c23fee6    # 0.010009503f
        -0x19faafbc
        -0x507cb8c5
        -0x5e69ba2
        -0x32023569
        0x5e7be48
        -0x256e8412
        -0x68f53003
        -0x3e49518d
        0x71d767a6
        -0x4dba11a5
        -0x12a3ce66
        0x4be64977    # 3.0184174E7f
        -0x2710f475
        -0x1cfd9e97
        0x7c90da6e
        0x9a76150
        0x7224b449
        -0x7279a8ce
        -0x31be1c0c
        -0x5464069
        0x32ceaad7
        -0x1705a2b6    # -9.4585E24f
        -0x7930511b
        0x70ce3be1
        -0x3aa82ce0
        0x2b507f5c
        -0x206f04a9
        0x4e7fe81
        -0x2b618c12
        -0x6c69e0ec
        -0x41409015
        0x3a13779d
        0x662a9be3
        0x5e2e6ff2
        -0x19f108fe
        0x3eb8273c
        0x36647b1d
        -0x8ab8065
        0x100e5fa6
        0x26c18c0b
        0x39e05ac0
        -0x1e272280    # -5.000572E20f
        0x57e786c1
        -0x42fc9c98
        0x31afe6fe
        0x3f6f08ce
        -0x2602d09
        0x7919df1f
        -0x11333022
        0x5cc3fdfd
        -0x137e4755
        0x3553d91a
        -0x85289d2
        -0x6039e80d
        -0x7b24136f
        0x69f5f9ba
        0x5e121f0c
        -0x20dbbb40
        0x17e929a8
        0xdc8e5a5
        0xd3814bf
        0x152a773a
        -0x2e99a133
        -0x27052fb
        -0x1801698c
        0x3c2fdc07
        0x38b90bc8
        -0x42b4322f
        -0x71cc1603
        -0x395efa37
        -0x2947808d
        -0x380df7c2
        -0x46d8c3c3
        0x6c9f41ee
        0x75db80b9
        0x9676146
        0x7a2accb8
        -0x67f84c51
        -0x6628f984
        0x772d0b12
        0x431731e2
        -0x4231e4c5
        0x9ce7dbe
        -0x18dda148
        0xf9bf483
        0x60dcef6f
        -0x1c657d45
        0x4eb3912d
        0x71ffde41
        0x79f33777
        0x2e7fcc37
        -0x8fcb094
        -0x5b3ac22b
        -0x741cbca0
        0x76e279f8
        0x3c3d9d55
        0x1be07d29
        0x126e1dfe
        -0x67e20c7c
        -0x480a7996
        0x5963c198
        -0x506dc97b
        0x34cfddbc
        0x704f3c87
        0x2718f76d
        0x5d16e0ae
        -0x28939bb5
        -0x2348234a
        -0x3824167
        0x27ec7070
        0x1563eea9
        0x5e141f0a
        -0x5176ae10
        0x5946466d
        0x1b609cf9
        0x5d29fba1
        0x6cd700f6
        -0x336c4e02    # -7.7434864E7f
        -0x15697d8f
        0x7f4f3a80
        0x17e64907
        0xef61080
        0x79d7a2ed
        -0x52194840
        0x5dafd9c8
        -0x6947b8cf
        -0x19bde48
        0x7f178df1
        -0x321e6196
        0x625d7056
        0x62344ccf
        -0x37932ffa
        0x7c7b3d07
        -0x31788466
        -0x328462c9
        0x77158cfb
        0x1ccfd5bc
        0x721fbb60
        0x371c6c37
        -0x6418e721
        0x6509ee3a
        -0x32a9493c
        0x7dabedee
        -0x4c7b1f02
        -0x12226164
        0x714ff582
        -0x7b2c0fab
        0x622c4ccf
        0x54c24265
        0x2cfc7674
        0x1a77cc93
        0x7dfe0fad
        0x7867fe8e
        0x7428afcc
        -0x6cc1020f
        0x6a3e994f
        -0x6cb41bb3
        0x70d769b6
        -0x4dd61187
        -0x6134d803    # -2.151E-20f
        -0x71406be9
        -0x11b610f6
        -0x87c1da3    # -5.34986E33f
        -0x7cc698a2
        0x33ceef05    # 9.6361E-8f
        -0x2ac1d010
        -0x3983664c
        0x251ad7ef
        0x14847bc2
        -0x1943b42d
        0x487c7ff7
        -0x4f62a4a5
        -0x230a26e4
        -0x26eb0825
        0x3d0609c1
        0x7da70372
        0x5e78778f
        0xb8408c5
        -0x8af32f9
        -0x10ab0029
        0x11aabdfe
        -0x3ec60c6b
        -0x2de8ae84
        -0x40b5cf1a
        0x913fb78
        -0x47a2288d
        -0x46881f23
        0x59dd71d7
        0x6573654b
        -0x23401111
        -0xe953463
        -0x11ca838d
        -0x20002786
        -0x31660873
        0x3e02f987
        0x3ee59777
        -0x55804db9
        -0x13c81e6c
        -0x6c3b0d1
        0x4199af63
        0x7fc5214e
        -0x6132ba03
        0x7ca6353e
        0x7ba74fb6
        -0x3bc25e6a
        0x3bdc33f8
        -0x19810d57
        -0x2263cd41
        0x3962333c
        -0xfe0d9e4
        -0xc2b86c2
        -0x20e8329a
        -0x41bb05f2
        0x283dd7d2
        -0x19cb2299
        0xf64afd9
        0xcb96b37
        -0x7e0d7853
        -0x6fd5c440
        0x9ff91b3
        0x36c3cfdd
        -0x419c2c39
        0x57a0f1bc
        -0x5880e049
        -0x594714d1
        0x57b239ee
        0x772e5bc4
        0x27f3c4f3
        0x390b6303
        0x38e17d19
        0x7270f00a
        -0x6c302b10
        -0x1592103d
        -0x1c4a904d
        0x5adbaf92
        -0x41ffc85b
        -0x6cdf2a8d    # -2.0300078E-27f
        -0x50a1f12d
        0x7c0e42ce
        0x7a7ff875
        -0x4c907dd
        0x683954c6
        0x4e83a769
        -0x3c5fd93d
        -0x467ed45e
        -0x393e229d
        -0x20bf1146
        0x4de6f1ef    # 4.8432688E8f
        0x7118cece
        -0x27577103
        0x4dcdf7a3    # 4.319448E8f
        -0x1021d02
        -0x49d1d4b0
        0x1fff1aee
        0x7acbb56c
        -0x7204a925
        -0x1ad2af54
        0x5fc417f7
        -0x7cb0931e
        -0x7b86a634
        0x31c83e32
        -0x7ccc81b5
        -0x1b7c1f81
        -0x20f27bc1
        0x66f580bb
        0x337a40e1
        -0x2b118f09
        -0xce18f11    # -1.2553001E31f
        -0x54e10f90
        0x612f28f3
        -0x12f22aa5
        -0x725b4e4b
        0x27e2ff1d
        -0x570996b2
        -0x5c8090f3
        0x373c3f85
        -0x136aa4e0
        0x6fe32eb8
        -0x4d84d424
        -0x386dc24
        0x3bb9168a
        -0x5da8bebb
        -0x45c8c347
        -0x4bfd61eb
        0x2c8367f9
        -0x4c5fb9c7
        0x5c2feb86
        -0x53f56476
        0x62819fd8
        -0x3802e179
        0x6b10ff0f
        0x12dcf75f
        0x3df7d5a6
        0x4ba726ac    # 2.1908824E7f
        -0x35f4e61f
        -0x62eacbbc
        -0x658b4f7d
        -0x24cd3b06
        0x4c4fabf
        0x71d7553e
        0x656bdc13
        0x7a73a7fb
        0x23e9827
        -0x190ee83c
        -0x63cf6487
        -0x408cc41f
        -0x21616e9a
        0x70de172a
        0x368d803f
        -0x41e2f2fb
        0x2387c225
        -0x78618f3f
        -0x313e5bd1
        0x7571801b
        0x23bbc1fd
        -0x6c21e2f
        0x7f8da4bf
        -0x5ac4c322
        -0x2bee5549
        0x38c223ff
        -0x1af869c
        0x14149d98
        0xbaaf025
        0x501ae705
        0x555932f8
        -0x475447a
        0x6b43beba
        0x186a72c7
        0x33e29dea
        -0x402cc080
        -0x24f8e8bf
        -0x6d185eb9
        -0x3788ef35
        -0x46366179
        -0x5def28ff
        0x499e8777
        0x26791cfa
        0x17d2e4e
        -0x9c70bfb
        0x1adf8f4d
        -0xbc31d6c
        -0x15865b9d
        -0x6d184e29
        0x71d73f4b
        -0x6fd28dd1
        -0x6e34e45d
        0x717e24d7
        -0x23b0f225
        0x6b36f3c7
        0x427da172
        0x7b3676a
        0x1e6feb07
        0x153f7d08
        -0x558a2c1f
        0x7f3e6e70
        0x6dca34b8
        -0x1b2764ea
        -0x14792500
        0x47289cd9
        0xf4a774d
        -0x7d4ddfe9
        0x280b5b00
        -0x1a2eb45f
        0x2a6505fc
        -0x6a780516
        -0x54b967ca
        -0x1a20e95e
        0x3e7e046b
        -0x194a120c
        0xb28a6f1
        -0x1842231
        -0x64936d85
        -0x5ba88886
        -0x41218d39
        -0xdb4a3cf
        0x3f32688b
        0x59bc7bc4
        -0x617f6b9d
        0x2eb438af
        0x2638dff4
        0x11a8d67e
        0x6f757cd
        -0x7844a1a2
        0x7047e60b
        0x37be7081
        0x4b5ddf37    # 1.4540599E7f
        -0x7408f904
        0x77ed060f
        -0x29b17e66
        0x2b4bd973
        -0x5124308d
        -0x398362f1
        -0x1f51b02a
        0x265be59e
        -0x2f4048b8
        0x5ba17e3f
        -0x32e321a5
        0x218f0ede
        0x6616f36b
        0x22f7c2ed
        0x7d638d70
        -0x11fb1a65
        -0x39bf0e71
        0x33e07f2b
        0x17c21d2f
        0x1f35e7a4
        0xb974be1
        -0x354f70c8    # -5785500.0f
        -0x1aa22829
        -0x3982ff81
        0x25cf379b
        -0x46523f7
        0x5c335f1b
        -0x8c4807d
        -0x44c1a66d
        0x6c997bb5
        0x14f26688
        0x7d3fd4f7
        -0x326b07
        0x767bbd61
        -0x3966fc9a
        0x31bffff4
        0x1aa8d8a1
        -0x2b3b20b
        0x566728db
        0x380e8a7e
        -0x3fd016c
        0x7f8fd8d6
        -0x19631521
        -0x40887804
        -0x6102869b
        -0x618b8151    # -1.294345E-20f
        -0x61af8636
        -0x6ac20841
        -0x450d3d44
        -0x6504f359
        0x72c8e8f7
        0x5ccfc571
        0x299be7be
        0x566fec58
        -0x1e7fa7c2
        -0x319f109
        0x6a53bcb7
        -0x20185282
        -0x5031088f    # -3.7647E-10f
        0xad6bc2f
        0x47c7661c
        -0x1a93207
        -0x5c52fc60
        0x6cc30428
        0x5af335e2
        0x7c8941c6
        0x757d7be1
        0x52cee37a
        -0x6c8e4083
        0x372857cc
        0x62d7d72b
        0x3fe48dfb    # 1.7855829f
        0x5a6fc65d
        -0x7053bade
        -0x825859d
        -0x343da8b0    # -2.5472672E7f
        -0x23e12511
        -0x27057472
        -0x78a92212
        0x74c0f79e
        -0x23eaa89
        0x7a1c5e7d
        0x6dd0898d
        0x59d3c3f6
        -0x7ad276f5
        0x3ab4d40c
        0x7066e4d
        0x78b07df6
        -0x6cf864ea
        -0x3de0545b
        -0x4bc62816
        -0x1868d379
        0x4bddfb0a    # 2.9095444E7f
        -0x35c38a34    # -3087731.0f
        0x5f153e87
        0x19f797e7
        -0xf32c32f
        -0x18a8bfa2
        -0x70801d52
        0x43d62091
        0x7be155f8
        0x1f992b1b
        -0x29141317
        0xdbff61b
        -0x7b7a862e
        -0x68040a7a
        0x27ca85f4
        -0x40543b1
        0x78e79ef0
        -0x2ccb58b1
        0x71df5f6b
        -0x6f37c2e2
        -0x5ece04ff
        -0x4923a0e3
        -0xf6a91a
        0x49dffc7c    # 1834895.5f
        0x2883189f
        -0xcc68303
        0x4e77da8a
        -0x421a57d
        0x44eef1e8
        -0x69a301e6
        0x62ff1e53
        -0x1990d0a8
        0xc173a38
        0x62679e74
        -0x3601e6cc    # -2081574.5f
        -0x47a07568
        -0x3bfe712
        0x339c6371
        -0x20a49470
        -0x37c2c1eb
        0x4ae59399    # 7522764.5f
        0x727f79e0
        0x70ecac6b
        -0x3a043111
        0x43cde525
        0x26d6ecbf
        0x178a7962
        -0x7380ee09
        0x7db50689
        -0x231cea9e
        -0x6c7a21a
        0x6fcd5b88
        -0x628c82d2
        -0x210e805a
        -0x818f63a
        -0x428cfe12
        0x7b6a0d12
        -0x463854c1
        -0x5b2da97b
        0x529f8774
        -0x4700123d
        -0x4e27e629
        -0x187daeb2
        -0x590817f7
        -0x3a82458d
        0x16ee7b6a
        0xd12b9c7
        -0x50bdd021
        -0x30b2cea1
        -0x171efae9
        0x3b77c7ce
        -0x47dec076
        -0x5390744
        0x5ee66061
        -0x27b088f6
        -0x3f82c053
        0x4122f796
        -0x5ec4ad21
        -0x6c394741
        0x396b2e76
        -0x49720602
        -0x15363947
        -0x30e6d4b0
        0x7fdfdf1d
        -0x8424bfa
        -0x7623a47a
        0xa65b277
        0x10dfa506
        -0x281139b3
        -0x393149cf
        -0x2067c528
        0x78ac7f69
        -0x79df23bd
        0x46bfaeb8
        -0x105acab8
        -0x1b218dac
        0x28f336b8
        -0x60180df9
        0x43b1b36d
        -0x33400912    # -1.0064472E8f
        0x69628cbf
        0x8c5fa03
        0x78eeeb9d
        0x3271df43
        0x6b91c8bd
        -0x1af7227b
        0x4688f148
        0x7ddc5fea
        0x26ec3e7c
        0x367e9ab3
        -0x373b6143
        0x29bc72ff
        0x34bdff24
        -0x23082fa6
        0x24726f59
        -0x451ade91
        0x5728f3ad
        -0x2b1a216e
        -0x915e78e
        0x758cf1b9
        0x3df53a3e    # 0.119739994f
        0x7ff37b91
        -0x471062cb
        0x49e4def2
        0x5428f3f9
        0x4e773f3e
        0x6ea6e998
        -0x294cc541
        -0x3119c142
        -0x308f45f1
        -0x36fc213a
        0x7ddfac49
        0x22f79627
        -0x6f34e421
        -0x6e05dba7
        0x1bf7d73e
        0x193406ae
        0x2d9d5653
        -0x4f9384b3
        -0x3e2df4cb
        0x57973dd3
        0x3fc73793
        0x43e69dcb
        0x20a35f5f
        -0x23083326
        0x24726f99
        -0x4514d611
        -0x73678094
        0x4d71fec5    # 2.53750352E8f
        -0x8c524ad
        -0x50fe0d69
        -0x43fefa35
        0x26a23660
        0x236a0b32
        0x503bf077
        0x1dfbf95f
        0x226ecd9b
        -0x18bc0204
        0x5dc8fca0
        0x37ae7b64
        -0x32ed4649
        0x5ca171fe
        0x726b9ad7
        -0x3480280f    # -1.6766961E7f
        0xd63d703
        -0x60ca4c0
        -0x7e04b858
        0xdf801b5
        0x5893557
        -0x1902aa5d
        0x1cc98efb
        0x74e713a0
        -0x132cad58
        0x7bf1bc49
        -0x1b218d7b
        -0x1d02d978
        0x79a535ac
        -0x1c1a4a89
        0x28627c7d
        -0x481b321f
        -0x35083c96    # -8118709.0f
        0x2e4c0df8
        0x5b39bcd4
        -0xbc5620d
        0x5f88f760
        0x48efefcc    # 491390.38f
        0x4779db92
        0x44ee2d5b
        -0x7aad8649
        0x42a9cfd3
        -0x541cd99f
        0x67db28f7
        0x76f651e6
        0x5e2b2887
        0x77a8c91e
        -0x4255b907
        -0x1ed63b09
        -0x2e65f359
        0x50f47910
        0x7dae7a9a
        -0x13e9bb8
        0x1a24befb
        -0x61dc7624
        0x5bbeee48
        0x7d565afa
        0x3e5dc4bd
        0x27ee7212
        0x455f22f7
        -0x69d05a65
        0x5bd3c2e5
        -0x2d346904
        0x5c0ee2be
        0x1bee7212
        0x455f22f7
        -0x295e209b
        -0xd41a8ba
        -0x73867965
        0x6ffdb6cf
        -0x3aa2c15e
        -0x67b61b22
        0x7a74fd4b
        -0x68600ecd
        -0x51585091
        -0x101f7545
        0x6c443193
        -0x37420a18
        -0x69a32104
        0x57e72155
        -0x47c6289a
        -0x2141cf21
        -0x2e4ee612
        -0x4dee3ab4
        0x22f7d6a5
        0x6b9f4cff
        -0x356d0910    # -4815736.0f
        0x5c6cef38
        0xd779988
        0x622e917b
        -0x142c6a5f
        0x1f2971f3
        -0x51898405
        -0x4c4734be
        0x143b89dc
        0x5b9f0aa7
        0x4d7b31cf    # 2.63396592E8f
        -0x31def2cd    # -6.754992E8f
        -0x8801b27
        -0xa87f489
        0x59886227
        -0x6e8414ac
        0x6ea74eef
        -0x1b262601
        -0x71788605
        -0x55230972
        -0x28e687f
        0x28f612b9
        -0x48a1a298
        -0x285af42f
        -0x10f53303
        -0x5c7412e3
        0x46e2be76
        0x51e649e4
        -0x21456a29
        -0x498c84cc
        -0x31d1ef7e    # -7.3007936E8f
        0x79145fa8    # 4.8150005E34f
        0x72ed3a0f
        -0x3b82325e
        -0x33683743    # -7.95786E7f
        -0xab49699
        -0x8d51dce
        -0x771827c2
        -0x7c979c90
        0x5fab286e
        0x2472fffc
        -0x179d8439
        -0x6657b002
        -0x6c144ec4
        -0x5a35114
        -0x2c58d612
        -0x14ec3a63
        0x44ee9f2f
        -0x1ac4c54a
        0x209e9141
        -0x4e0082cd
        0x79afccb3
        0x73f849d9
        -0x2941ca12
        0x6b12c5bd
        0x44ee9f4f
        0x117be82e
        0x7670988c
        -0x25ff3a7b
        -0x9f1f017
        -0x4db15337
        0x5fb47374
        0x49efd8f1
        0x15dcd720
        -0x75c07624
        0x3fff4277
        -0x488e91f9
        -0x78518613
        -0x44836529
        -0x21a175e8
        -0xee8292
        0x465e8ffe
        -0x9319211
        -0xf3a3af2
        -0x9823ba8
        -0x2189db8e
        0x2f4a94ed
        0x49e45e94    # 1870802.5f
        0x28db93c8
        -0x42d7ae4a
        0x27917b51
        -0x5d93b0de
        -0x85dbb27
        -0x61bb11bb
        -0x764dc277
        -0x2374ed9b
        0x7b12b917
        0x25caf624
        0x722f4a94
        -0x12b61ba2
        -0x6bd7246d
        -0x3742d7af
        -0x49d86e85
        0x51a26c4f
        0x22f7a244
        -0x2661bb12
        0x4589b23d
        -0x762374ee
        0x657b12b9
        0x1725caf6
        0x24722f4a
        -0x6b12761c
        -0x1030628
        0x3e5151d1
        -0x555757e8
        -0x2f901d01
        0x452bd1df
        -0x145d5d5e
        -0x1367633d
        0x74dada8e
        -0x7373765e
        -0x64d90512
        0xda6f921
        -0x2dd871db
        -0x2d1fd901
        -0x654d7674
        -0x7309b897
        0x4f0b0f4f
        0x7a9d497e
        0x1ae68d5e
        0x3969ce6b
        -0x525b25b
        0x4994a1e6    # 1217596.8f
        0x3bb16eec
        -0xdb440d4
        0x4951ee9f
        -0x3684b209
        0x3ad8948d
        -0x517784a9
        0x5bcf51b9
        0x447b303d
        -0x61b68137
        0x7227cec3
        -0x4b030bf7
        -0x6293dbaf
        0x7c9fcd7
        -0x697cad0d
        0x6f515abf
        0x7940724f
        -0x3c402ce
        0x55e799f6
        -0x10decdb3
        -0x6437d44d
        0x344d7f5f
        -0x4a70d48
        0x285abfff
        -0x3fdd00d6
        -0x498a7927
        0x7962804e
        0x7d615af6
        0x4c78615a    # 6.51114E7f
        -0x690a382b
        -0x68d60c8d
        0x7157360d
        -0x30ee14ba    # -2.4481152E9f
        -0x4270b371
        0x3727bf44
        0x1bc026cf
        -0x6549d5ba
        0x41e7de92
        -0x16141c62
        0x4847d744
        0x5d2058d7
        0x6e4b9873
        -0x5cd092a3
        0x334d9369
        -0x24338a02
        -0x764d5693
        0x6b3d34f1
        0x73b8674
        -0xc39a2a7
        0x194f53d3
        -0x8ed8ee4
        -0xc89ebf1
        -0x8236a73
        -0x51150498
        0x32be6376
        0x5d4cf2ab
        0x2977753b
        -0x5c3cd34d
        -0x47b46437
        0x1805c129
        -0x6ec99ef3
        -0x4ca516d5
        -0x779c0b8f
        0x6fec1cda
        0x7110bd18
        -0x7232c25a
        -0x60998204
        0x4db7ad34
        -0x78848521
        0x27eea526
        0x5f443bc0
        -0x5bf14d1b
        -0x7774cb4b
        -0x24ad858b
        0xf17f74c
        -0x313adfb1
        0x76d47e84
        -0x35f6440c    # -2256637.0f
        -0x1718484a
        0x5f8d625e
        -0x12b073c    # -1.41544E38f
        -0xf86cb17
        -0x541c828b
        0x3fc494fb
        -0x25cb4b06
        0x3f26dfa7
        0x732d7444
        -0x1ea1a621
        -0x612e1459
        -0x7196170
        -0x3163ff13
        -0x457c6c05
        -0x2510d568
        -0x4a1630f1
        -0x8db14e6
        -0x1152500
        -0x494efc65
        -0x3ad049a
        0x3afd18a5
        -0x52a738dc
        0x6f6cb8af
        -0x32e06c4a
        -0x73b811cb
        -0x87a3d68
        -0x3614e87e
        0x7b42b531
        0x16c373e1
        -0x19a12c81
        0x10710ad7
        0x696b1f67
        0x79dcd7c7
        -0x346541aa    # -2.028254E7f
        -0x8406659
        -0x38d1401c
        0x58914edb
        -0x3409e331    # -3.2258462E7f
        0x3f79aff
        -0x59e810d0
        -0x3244418d
        0x31cb67dd
        -0x2774a961
        -0x70608402
        -0x157ec619
        0x31e75c74
        0x543bc7a1
        -0x2a402839
        -0x5331973
        0x4999c13d
        -0x4a40cfc6
        0x3f54df46
        0x309b4766
        -0x3c821204
        0x21ed5844
        0x8ee0991
        0x318fa9be
        0x4a58eec9    # 3554226.2f
        -0x9772124
        0x307eee6d
        -0x4c407056
        -0x6028ab2c
        -0xa48254
        -0x3099b230    # -3.8638592E9f
        -0x63036d39
        -0x651da6cd
        0x66673e8f
        0x64def89e
        0x6e5d1686
        0x7b6abc4f
        -0x6b781e9d
        -0x7a1c6126
        -0x70cfa48d
        -0x3c3c8283
        -0x24964704
        -0x27595283
        -0x635a8ea1
        0x370fabb5
        0x3e4d290f
        -0x39144d9a
        0x724f6b9e
        0x45d336d5
        -0x30de2cc3
        0x173beeeb
        -0x9ca2f54
        0x1bc2704f
        -0x773167a6
        0x48eea9e7
        -0x5c4c18ff
        0x27f7daf3
        -0x60331b9
        0x5812f7c6
        -0x5ce590f
        -0x70094e9a
        0x71bf8eee
        0x18a376bd
        0x4e6bfdd8    # 9.8982042E8f
        0x545d63c2
        0x7d6dfa94
        -0xab2854f
        -0x7011a545
        0x2133295b
        0x63f98daa
        -0x6020a817
        -0x74820f8f
        0x6fbacfa0
        -0x23c4ec05
        0x1b19cd11
        0x1b3d4613
        0x27d5af3d
        0x46b15a7f
        -0x5f40e0ad
        -0x8042361
        -0x7496e4bc
        -0x952f205
        0x31ea9896
        0x45baacb9
        -0x5853dc2e
        0x2a9fda7c
        -0x512cd1e5
        -0x3201ce83
        0xcd0dfaf
        -0x5862e16d
        0x7d4574b9
        0x67b23fca
        0x188bc475
        0x52dabf06
        0x75d83ab8
        0x37d94632
        -0x27d03678
        0x4d46ebd5    # 2.08584016E8f
        -0x33a72891    # -5.6843708E7f
        -0x51303a5c
        0x6cb4d782
        0xcc68706
        -0x24fa8507
        -0x1a6084ae
        -0x654520a0
        -0xa77c03
        -0x5cd30917
        0x2a98ae67
        -0x1551468f
        -0x4e4035ec
        -0x742b0051
        0x5b0f7071
        0x4f73fdbc
        -0x1144236b
        0x155d06d9
        -0x30c06636
        -0x5061c272
        -0x4312289d
        -0x69802c8f
        0x7cfdd891
        -0x2641a2cd
        -0x346a8964
        0x6f388d58
        0x372affd4
        -0x46fd0505
        0x7435f960
        0x37ce116e
        0x7c4f1539
        -0x2856e411
        0xbc9bda5
        -0x32141621
        0x634c7fef
        0x357f9b5
        -0x6b0ec243
        0x677deae3
        0x24767116
        0x7ff37a74
        0x448d1dc8
        -0x677a1108
        0x5e67ae9c
        -0x2e23d9d2
        -0x11f61625
        0x32124f7
        -0x294f71b9
        0x59a7d63b
        0x1f624eda
        -0x79703c31
        -0x4209c5e3
        0x6d0bb2f7
        -0x6d3d56a7
        -0x30fb6d5e
        -0x4db0239d
        0x26f37a6c
        -0x14f8b112
        -0x56029203
        0x3e2c21b9
        -0x487182c5
        -0x6b02e07e
        -0x739ed27f
        0x7beabe1c
        0x53e312ea
        0x3a119be7
        -0x5e671a75
        -0x141e246
        -0x2d62609c
        -0x4571b8e7
        0x2fd08e09
        0x7172aff9
        0x6edd5849
        -0x3a99816a
        0x6dfead69
        -0x60d18a41
        0x23b3395b
        -0x141a6117
        0x73f6f5f1
        0x3edfcf2c
        0x317bee8d
        0x7ebaecb9
        -0x58395294
        -0x290e4747
        0x2e66952
        -0x4220541
        -0x3a188d4c
        -0x4038d3ca
        0x619276c3
        -0x1c0f8d51
        0x1d07d2ab
        -0x386b06de
        0x5e9effd2
        0x3e07bdf6
        -0x6811a39a
        -0x6b3121bd
        0x36fb7698
        -0x397b6940    # -16971.375f
        -0x4209829a
        -0x993ca0d
        0x36e67978
        0xef7f9de
        -0x48bc2621
        0x4abb4f65    # 6137778.5f
        -0x25a9cf37
        0x6f14cbe7
        0x706bdfd9
        0x63749f5e
        -0x12c77a24
        0x77a36eb3
        -0x3382f169    # -6.6337372E7f
        -0x16018346
        -0x14c3b32e
        0x34f55d52
        -0x2b46f24a
        -0x23a40485
        0x374c7d57
        -0x48818f67
        -0x49098e88
        -0x20443ecc
        0x66a71c47
        -0x39bb7362
        -0x4cb0b22
        0xd3defc5
        -0x5f62d863
        0x7d2a50fb
        0x4e2d0fe2    # 7.2587482E8f
        0x7c9a36aa
        0x619d34f6
        -0x41e2c519
        -0x5bc3fcbd
        -0x1ca6be5a
        -0x1056cd43
        0x5e62c698
        0x3b8a7a3f
        -0x17e33cc4
        -0x3d4299
        -0x741498cb
        0x75fa3446
        -0x4f217a2
        -0x5c19c702
        -0x204c9a58
        0x6c74db71
        0x26f9a63c
        -0x5c908dc3
        -0x64b28167
        -0x4198548a    # -0.22624001f
        -0x60714017
        -0xb2a1c0e
        -0x45845b05
        0x5e4dba71
        0xff5bd96
        0x74bfcbac
        0x1c8cd723
        0x36ef6524
        0x541b4fdd
        0x783edeab
        -0x5649364f
        0x38d3775f
        0x46d5edd5
        0x303d8eb3
        -0x230895e6
        0x2e1bca1c
        0x26e3fd0a
        0x641f4ba7
        -0x21f406a2
        0x4d4dbd56    # 2.157336E8f
        -0x812ae6c
        -0x4a14450c
        0x75eba4f8
        0x1e6d51a2
        0x6c4f24f7
        -0x5dba744a
        0x2dff3ffa
    .end array-data

    .line 213
    :array_3
    .array-data 1
        0x3ct
        -0x64t
        0xft
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static CheckCompressedWatermarkData([B)Z
    .locals 4
    .param p0, "data"    # [B

    .prologue
    .line 86
    :try_start_0
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 87
    invoke-virtual {v2, p0}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v2

    .line 97
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aCompressedHash:[B

    invoke-static {v2, v3}, Ljava/util/Arrays;->equals([B[B)Z
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 106
    .local v0, "dataIsGood":Z
    :goto_0
    return v0

    .line 100
    .end local v0    # "dataIsGood":Z
    :catch_0
    move-exception v1

    .line 102
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Error checking hash: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 103
    const/4 v0, 0x0

    .restart local v0    # "dataIsGood":Z
    goto :goto_0
.end method

.method public static CheckWatermarkData()Z
    .locals 4

    .prologue
    .line 110
    const/4 v0, 0x0

    .line 112
    .local v0, "dataIsGood":Z
    sget-object v2, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aImageData:[B

    if-eqz v2, :cond_0

    .line 116
    :try_start_0
    const-string v2, "MD5"

    invoke-static {v2}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .line 117
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aImageData:[B

    invoke-virtual {v2, v3}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v2

    .line 127
    sget-object v3, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aUncompressedHash:[B

    invoke-static {v2, v3}, Ljava/util/Arrays;->equals([B[B)Z
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 136
    :cond_0
    :goto_0
    return v0

    .line 130
    :catch_0
    move-exception v1

    .line 132
    .local v1, "e":Ljava/security/NoSuchAlgorithmException;
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Error checking hash: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    goto :goto_0
.end method

.method private static DecompressByteArray([B)[B
    .locals 7
    .param p0, "data"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Ljava/util/zip/DataFormatException;
        }
    .end annotation

    .prologue
    .line 194
    new-instance v2, Ljava/util/zip/Inflater;

    invoke-direct {v2}, Ljava/util/zip/Inflater;-><init>()V

    .line 195
    .local v2, "inflater":Ljava/util/zip/Inflater;
    invoke-virtual {v2, p0}, Ljava/util/zip/Inflater;->setInput([B)V

    .line 196
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    array-length v5, p0

    invoke-direct {v4, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 197
    .local v4, "outputStream":Ljava/io/ByteArrayOutputStream;
    const/16 v5, 0x400

    new-array v0, v5, [B

    .line 198
    .local v0, "buffer":[B
    :goto_0
    invoke-virtual {v2}, Ljava/util/zip/Inflater;->finished()Z

    move-result v5

    if-nez v5, :cond_0

    .line 200
    invoke-virtual {v2, v0}, Ljava/util/zip/Inflater;->inflate([B)I

    move-result v1

    .line 201
    .local v1, "count":I
    const/4 v5, 0x0

    invoke-virtual {v4, v0, v5, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 203
    .end local v1    # "count":I
    :cond_0
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 204
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v3

    .line 205
    .local v3, "output":[B
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Compressed: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v6, p0

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 206
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "Original: "

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v6, v3

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 207
    return-object v3
.end method

.method public static PrepareImage()Z
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 143
    const/4 v0, 0x1

    .line 145
    .local v0, "bAllGood":Z
    sget-boolean v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_bImagePrepared:Z

    if-nez v6, :cond_1

    .line 147
    const/4 v6, 0x1

    sput-boolean v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_bImagePrepared:Z

    .line 150
    sget-object v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage:[I

    array-length v6, v6

    mul-int/lit8 v4, v6, 0x4

    .line 151
    .local v4, "iNumBytes":I
    invoke-static {v4}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 152
    .local v1, "byteBuffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->asIntBuffer()Ljava/nio/IntBuffer;

    move-result-object v6

    .line 153
    sget-object v7, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage:[I

    invoke-virtual {v6, v7}, Ljava/nio/IntBuffer;->put([I)Ljava/nio/IntBuffer;

    .line 155
    sget-object v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage_TrailingBytes:[B

    array-length v6, v6

    add-int/2addr v6, v4

    .line 156
    new-array v5, v6, [B

    .line 157
    .local v5, "zippedByteData":[B
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->array()[B

    move-result-object v6

    invoke-static {v6, v8, v5, v8, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 159
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    sget-object v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage_TrailingBytes:[B

    array-length v6, v6

    if-ge v3, v6, :cond_0

    .line 161
    add-int v6, v4, v3

    sget-object v7, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->m_aCompressedImage_TrailingBytes:[B

    aget-byte v7, v7, v3

    aput-byte v7, v5, v6

    .line 159
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 166
    :cond_0
    invoke-static {v5}, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->CheckCompressedWatermarkData([B)Z

    move-result v0

    .line 168
    if-eqz v0, :cond_1

    .line 172
    :try_start_0
    invoke-static {v5}, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->DecompressByteArray([B)[B

    move-result-object v6

    sput-object v6, Lcom/RenderHeads/AVProVideo/AVProMobileWMImage;->s_aImageData:[B
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/util/zip/DataFormatException; {:try_start_0 .. :try_end_0} :catch_1

    .line 187
    .end local v1    # "byteBuffer":Ljava/nio/ByteBuffer;
    .end local v3    # "i":I
    .end local v4    # "iNumBytes":I
    .end local v5    # "zippedByteData":[B
    :cond_1
    :goto_1
    return v0

    .line 174
    .restart local v1    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v3    # "i":I
    .restart local v4    # "iNumBytes":I
    .restart local v5    # "zippedByteData":[B
    :catch_0
    move-exception v2

    .line 176
    .local v2, "e":Ljava/io/IOException;
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "DecompressByteArray: IOException: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 177
    const/4 v0, 0x0

    .line 183
    goto :goto_1

    .line 179
    .end local v2    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v2

    .line 181
    .local v2, "e":Ljava/util/zip/DataFormatException;
    new-instance v6, Ljava/lang/StringBuilder;

    const-string v7, "DecompressByteArray: DataFormatException: "

    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    .line 182
    const/4 v0, 0x0

    goto :goto_1
.end method
