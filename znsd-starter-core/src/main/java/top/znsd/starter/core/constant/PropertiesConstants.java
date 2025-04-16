/*
 * Copyright (c) 2022-present Charles7c Authors. All Rights Reserved.
 * <p>
 * Licensed under the GNU LESSER GENERAL PUBLIC LICENSE 3.0;
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.gnu.org/licenses/lgpl.html
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package top.znsd.starter.core.constant;

/**
 * 配置属性相关常量
 *
 * @author administrator
 * @since 1.1.1
 */
public class PropertiesConstants {

    /**
     * Znsd Starter
     */
    public static final String ZNSD_STARTER = "znsd-starter";

    /**
     * 启用配置
     */
    public static final String ENABLED = "enabled";

    /**
     * 安全配置
     */
    public static final String SECURITY = ZNSD_STARTER + StringConstants.DOT + "security";

    /**
     * 安全-密码编解码配置
     */
    public static final String SECURITY_PASSWORD = SECURITY + StringConstants.DOT + "password";

    /**
     * 安全-加/解密配置
     */
    public static final String SECURITY_CRYPTO = SECURITY + StringConstants.DOT + "crypto";

    /**
     * 安全-敏感词配置
     */
    public static final String SECURITY_SENSITIVE_WORDS = SECURITY + StringConstants.DOT + "sensitive-words";

    /**
     * 安全-XSS 配置
     */
    public static final String SECURITY_XSS = SECURITY + StringConstants.DOT + "xss";

    /**
     * Web 配置
     */
    public static final String WEB = ZNSD_STARTER + StringConstants.DOT + "web";

    /**
     * Web-跨域配置
     */
    public static final String WEB_CORS = WEB + StringConstants.DOT + "cors";

    /**
     * Web-响应配置
     */
    public static final String WEB_RESPONSE = WEB + StringConstants.DOT + "response";

    /**
     * 日志配置
     */
    public static final String LOG = ZNSD_STARTER + StringConstants.DOT + "log";

    /**
     * 存储配置
     */
    public static final String STORAGE = ZNSD_STARTER + StringConstants.DOT + "storage";

    /**
     * 验证码配置
     */
    public static final String CAPTCHA = ZNSD_STARTER + StringConstants.DOT + "captcha";

    /**
     * 图形验证码配置
     */
    public static final String CAPTCHA_GRAPHIC = CAPTCHA + StringConstants.DOT + "graphic";

    /**
     * 行为验证码配置
     */
    public static final String CAPTCHA_BEHAVIOR = CAPTCHA + StringConstants.DOT + "behavior";

    /**
     * 消息配置
     */
    public static final String MESSAGING = ZNSD_STARTER + StringConstants.DOT + "messaging";

    /**
     * WebSocket 配置
     */
    public static final String MESSAGING_WEBSOCKET = MESSAGING + StringConstants.DOT + "websocket";

    /**
     * CRUD 配置
     */
    public static final String CRUD = ZNSD_STARTER + StringConstants.DOT + "crud";

    /**
     * 数据权限配置
     */
    public static final String DATA_PERMISSION = ZNSD_STARTER + StringConstants.DOT + "data-permission";

    /**
     * 多租户配置
     */
    public static final String TENANT = ZNSD_STARTER + StringConstants.DOT + "tenant";

    /**
     * 限流配置
     */
    public static final String RATE_LIMITER = ZNSD_STARTER + StringConstants.DOT + "rate-limiter";

    /**
     * 幂等配置
     */
    public static final String IDEMPOTENT = ZNSD_STARTER + StringConstants.DOT + "idempotent";

    /**
     * 链路追踪配置
     */
    public static final String TRACE = ZNSD_STARTER + StringConstants.DOT + "trace";

    private PropertiesConstants() {
    }
}
