/*** Autogenerated by WIDL 8.21 from include/windows.graphics.effects.idl - Do not edit ***/

#ifdef _WIN32
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif
#include <rpc.h>
#include <rpcndr.h>
#endif

#ifndef COM_NO_WINDOWS_H
#include <windows.h>
#include <ole2.h>
#endif

#ifndef __windows_graphics_effects_h__
#define __windows_graphics_effects_h__

#ifndef __WIDL_INLINE
#if defined(__cplusplus) || defined(_MSC_VER)
#define __WIDL_INLINE inline
#elif defined(__GNUC__)
#define __WIDL_INLINE __inline__
#endif
#endif

/* Forward declarations */

#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_FWD_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_FWD_DEFINED__
typedef interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect;
#ifdef __cplusplus
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect ABI::Windows::Graphics::Effects::IGraphicsEffect
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                interface IGraphicsEffect;
            }
        }
    }
}
#endif /* __cplusplus */
#endif

#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_FWD_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_FWD_DEFINED__
typedef interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource;
#ifdef __cplusplus
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource ABI::Windows::Graphics::Effects::IGraphicsEffectSource
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                interface IGraphicsEffectSource;
            }
        }
    }
}
#endif /* __cplusplus */
#endif

/* Headers for imported files */

#include <inspectable.h>
#include <asyncinfo.h>
#include <eventtoken.h>
#include <windowscontracts.h>
#include <windows.foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_FWD_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_FWD_DEFINED__
typedef interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect;
#ifdef __cplusplus
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect ABI::Windows::Graphics::Effects::IGraphicsEffect
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                interface IGraphicsEffect;
            }
        }
    }
}
#endif /* __cplusplus */
#endif

#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_FWD_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_FWD_DEFINED__
typedef interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource;
#ifdef __cplusplus
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource ABI::Windows::Graphics::Effects::IGraphicsEffectSource
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                interface IGraphicsEffectSource;
            }
        }
    }
}
#endif /* __cplusplus */
#endif

/*****************************************************************************
 * IGraphicsEffect interface
 */
#if WINDOWS_FOUNDATION_UNIVERSALAPICONTRACT_VERSION >= 0x10000
#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_INTERFACE_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_INTERFACE_DEFINED__

DEFINE_GUID(IID___x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect, 0xcb51c0ce, 0x8fe6, 0x4636, 0xb2,0x02, 0x86,0x1f,0xaa,0x07,0xd8,0xf3);
#if defined(__cplusplus) && !defined(CINTERFACE)
} /* extern "C" */
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                MIDL_INTERFACE("cb51c0ce-8fe6-4636-b202-861faa07d8f3")
                IGraphicsEffect : public IInspectable
                {
                    virtual HRESULT STDMETHODCALLTYPE get_Name(
                        HSTRING *name) = 0;

                    virtual HRESULT STDMETHODCALLTYPE put_Name(
                        HSTRING name) = 0;

                };
            }
        }
    }
}
extern "C" {
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect, 0xcb51c0ce, 0x8fe6, 0x4636, 0xb2,0x02, 0x86,0x1f,0xaa,0x07,0xd8,0xf3)
#endif
#else
typedef struct __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This);

    /*** IInspectable methods ***/
    HRESULT (STDMETHODCALLTYPE *GetIids)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        ULONG *iidCount,
        IID **iids);

    HRESULT (STDMETHODCALLTYPE *GetRuntimeClassName)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        HSTRING *className);

    HRESULT (STDMETHODCALLTYPE *GetTrustLevel)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        TrustLevel *trustLevel);

    /*** IGraphicsEffect methods ***/
    HRESULT (STDMETHODCALLTYPE *get_Name)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        HSTRING *name);

    HRESULT (STDMETHODCALLTYPE *put_Name)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect *This,
        HSTRING name);

    END_INTERFACE
} __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectVtbl;

interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect {
    CONST_VTBL __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_AddRef(This) (This)->lpVtbl->AddRef(This)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_Release(This) (This)->lpVtbl->Release(This)
/*** IInspectable methods ***/
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetIids(This,iidCount,iids) (This)->lpVtbl->GetIids(This,iidCount,iids)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetRuntimeClassName(This,className) (This)->lpVtbl->GetRuntimeClassName(This,className)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetTrustLevel(This,trustLevel) (This)->lpVtbl->GetTrustLevel(This,trustLevel)
/*** IGraphicsEffect methods ***/
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_get_Name(This,name) (This)->lpVtbl->get_Name(This,name)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_put_Name(This,name) (This)->lpVtbl->put_Name(This,name)
#else
/*** IUnknown methods ***/
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_QueryInterface(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static __WIDL_INLINE ULONG __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_AddRef(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This) {
    return This->lpVtbl->AddRef(This);
}
static __WIDL_INLINE ULONG __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_Release(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This) {
    return This->lpVtbl->Release(This);
}
/*** IInspectable methods ***/
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetIids(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,ULONG *iidCount,IID **iids) {
    return This->lpVtbl->GetIids(This,iidCount,iids);
}
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetRuntimeClassName(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,HSTRING *className) {
    return This->lpVtbl->GetRuntimeClassName(This,className);
}
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetTrustLevel(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,TrustLevel *trustLevel) {
    return This->lpVtbl->GetTrustLevel(This,trustLevel);
}
/*** IGraphicsEffect methods ***/
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_get_Name(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,HSTRING *name) {
    return This->lpVtbl->get_Name(This,name);
}
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_put_Name(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect* This,HSTRING name) {
    return This->lpVtbl->put_Name(This,name);
}
#endif
#ifdef WIDL_using_Windows_Graphics_Effects
#define IID_IGraphicsEffect IID___x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect
#define IGraphicsEffectVtbl __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectVtbl
#define IGraphicsEffect __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect
#define IGraphicsEffect_QueryInterface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_QueryInterface
#define IGraphicsEffect_AddRef __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_AddRef
#define IGraphicsEffect_Release __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_Release
#define IGraphicsEffect_GetIids __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetIids
#define IGraphicsEffect_GetRuntimeClassName __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetRuntimeClassName
#define IGraphicsEffect_GetTrustLevel __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_GetTrustLevel
#define IGraphicsEffect_get_Name __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_get_Name
#define IGraphicsEffect_put_Name __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_put_Name
#endif /* WIDL_using_Windows_Graphics_Effects */
#endif

#endif

#endif  /* ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffect_INTERFACE_DEFINED__ */
#endif /* WINDOWS_FOUNDATION_UNIVERSALAPICONTRACT_VERSION >= 0x10000 */

/*****************************************************************************
 * IGraphicsEffectSource interface
 */
#if WINDOWS_FOUNDATION_UNIVERSALAPICONTRACT_VERSION >= 0x10000
#ifndef ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_INTERFACE_DEFINED__
#define ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_INTERFACE_DEFINED__

DEFINE_GUID(IID___x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource, 0x2d8f9ddc, 0x4339, 0x4eb9, 0x92,0x16, 0xf9,0xde,0xb7,0x56,0x58,0xa2);
#if defined(__cplusplus) && !defined(CINTERFACE)
} /* extern "C" */
namespace ABI {
    namespace Windows {
        namespace Graphics {
            namespace Effects {
                MIDL_INTERFACE("2d8f9ddc-4339-4eb9-9216-f9deb75658a2")
                IGraphicsEffectSource : public IInspectable
                {
                };
            }
        }
    }
}
extern "C" {
#ifdef __CRT_UUID_DECL
__CRT_UUID_DECL(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource, 0x2d8f9ddc, 0x4339, 0x4eb9, 0x92,0x16, 0xf9,0xde,0xb7,0x56,0x58,0xa2)
#endif
#else
typedef struct __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSourceVtbl {
    BEGIN_INTERFACE

    /*** IUnknown methods ***/
    HRESULT (STDMETHODCALLTYPE *QueryInterface)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This,
        REFIID riid,
        void **ppvObject);

    ULONG (STDMETHODCALLTYPE *AddRef)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This);

    ULONG (STDMETHODCALLTYPE *Release)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This);

    /*** IInspectable methods ***/
    HRESULT (STDMETHODCALLTYPE *GetIids)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This,
        ULONG *iidCount,
        IID **iids);

    HRESULT (STDMETHODCALLTYPE *GetRuntimeClassName)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This,
        HSTRING *className);

    HRESULT (STDMETHODCALLTYPE *GetTrustLevel)(
        __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource *This,
        TrustLevel *trustLevel);

    END_INTERFACE
} __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSourceVtbl;

interface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource {
    CONST_VTBL __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSourceVtbl* lpVtbl;
};

#ifdef COBJMACROS
#ifndef WIDL_C_INLINE_WRAPPERS
/*** IUnknown methods ***/
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_AddRef(This) (This)->lpVtbl->AddRef(This)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_Release(This) (This)->lpVtbl->Release(This)
/*** IInspectable methods ***/
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetIids(This,iidCount,iids) (This)->lpVtbl->GetIids(This,iidCount,iids)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetRuntimeClassName(This,className) (This)->lpVtbl->GetRuntimeClassName(This,className)
#define __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetTrustLevel(This,trustLevel) (This)->lpVtbl->GetTrustLevel(This,trustLevel)
#else
/*** IUnknown methods ***/
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_QueryInterface(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This,REFIID riid,void **ppvObject) {
    return This->lpVtbl->QueryInterface(This,riid,ppvObject);
}
static __WIDL_INLINE ULONG __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_AddRef(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This) {
    return This->lpVtbl->AddRef(This);
}
static __WIDL_INLINE ULONG __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_Release(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This) {
    return This->lpVtbl->Release(This);
}
/*** IInspectable methods ***/
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetIids(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This,ULONG *iidCount,IID **iids) {
    return This->lpVtbl->GetIids(This,iidCount,iids);
}
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetRuntimeClassName(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This,HSTRING *className) {
    return This->lpVtbl->GetRuntimeClassName(This,className);
}
static __WIDL_INLINE HRESULT __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetTrustLevel(__x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource* This,TrustLevel *trustLevel) {
    return This->lpVtbl->GetTrustLevel(This,trustLevel);
}
#endif
#ifdef WIDL_using_Windows_Graphics_Effects
#define IID_IGraphicsEffectSource IID___x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource
#define IGraphicsEffectSourceVtbl __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSourceVtbl
#define IGraphicsEffectSource __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource
#define IGraphicsEffectSource_QueryInterface __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_QueryInterface
#define IGraphicsEffectSource_AddRef __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_AddRef
#define IGraphicsEffectSource_Release __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_Release
#define IGraphicsEffectSource_GetIids __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetIids
#define IGraphicsEffectSource_GetRuntimeClassName __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetRuntimeClassName
#define IGraphicsEffectSource_GetTrustLevel __x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_GetTrustLevel
#endif /* WIDL_using_Windows_Graphics_Effects */
#endif

#endif

#endif  /* ____x_ABI_CWindows_CGraphics_CEffects_CIGraphicsEffectSource_INTERFACE_DEFINED__ */
#endif /* WINDOWS_FOUNDATION_UNIVERSALAPICONTRACT_VERSION >= 0x10000 */

/* Begin additional prototypes for all interfaces */

ULONG           __RPC_USER HSTRING_UserSize     (ULONG *, ULONG, HSTRING *);
unsigned char * __RPC_USER HSTRING_UserMarshal  (ULONG *, unsigned char *, HSTRING *);
unsigned char * __RPC_USER HSTRING_UserUnmarshal(ULONG *, unsigned char *, HSTRING *);
void            __RPC_USER HSTRING_UserFree     (ULONG *, HSTRING *);

/* End additional prototypes */

#ifdef __cplusplus
}
#endif

#endif /* __windows_graphics_effects_h__ */
