

 即将裸辞,上传个demo压压惊
云台手柄:
        class->HandleView
        直接 alloc init   自定义手柄大小  通过代理接收方向返回消息<HandleDelegate> 有8个方向.
通过四条直线将圆分为8片区域,x = y, x = -y, y = 0, x = 0;
        对View添加 UIPanGestureRecognizer 事件.

        UIGestureRecognizerStateChanged:
    (1) 如果滑动到圆的外面,将句柄移到圆的路径上.
    (2) 判断点所在的区域后 协议返回代表方向的数字 .

//------------------------------------------------------------------------------

