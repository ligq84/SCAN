package com.fh.interceptor;

/**
 * Created by pillar on 2017/10/14.
 */

import java.lang.annotation.*;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {

    String model() default "没有默认模块";

    String function() default "没有默认功能";

    String type() default "没有默认类型";

}