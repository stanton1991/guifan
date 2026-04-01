-- =====================================================
-- 建筑防火通用规范 GB 55037-2022 数据导入文件
-- 生成时间: 2026-03-31
-- 数据来源: 中华人民共和国住房和城乡建设部官方PDF
-- 条文数量: 114 条
-- =====================================================

-- 创建用户表
create table if not exists public.app_users (
    id bigserial primary key,
    username text not null unique,
    password_hash text not null,
    created_at timestamptz not null default now()
);

-- 创建规范条文表
create table if not exists public.building_codes (
    id bigserial primary key,
    code_name text not null,
    clause_no text,
    title text not null,
    content text not null,
    keywords text,
    updated_at timestamptz not null default now()
);

-- 插入条文数据

insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.1.1', '建筑的防火性能和设防标准应与建筑的高度、层', '建筑的防火性能和设防标准应与建筑的高度、层', '防火,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.1', '建筑的消防救援设施应与建筑的高度、进深、规模', '建筑的消防救援设施应与建筑的高度、进深、规模', '消防,建筑,救援,消防救援');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.2', '在建筑与消防车登高操作场地相对应的范围内，应设置直', '在建筑与消防车登高操作场地相对应的范围内，应设置直', '消防,建筑,登高,操作场地');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.3', '除有特殊要求的建筑和甲类厂房可不设置消防救援口外，', '除有特殊要求的建筑和甲类厂房可不设置消防救援口外，', '消防,建筑,甲类,救援,消防救援');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.4', '设置机械加压送风系统并靠外墙或可直通屋面的封闭楼', '设置机械加压送风系统并靠外墙或可直通屋面的封闭楼', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.5', '除有特殊功能、性能要求或火灾发展缓慢的场所可不在外', '除有特殊功能、性能要求或火灾发展缓慢的场所可不在外', '火灾');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.6', '除城市综合管廊、交通隧道和室内尤车道且尤人员停留的', '除城市综合管廊、交通隧道和室内尤车道且尤人员停留的', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.7', '埋深大千 15m 的地铁车站公共区应设置消防专用通道。', '埋深大千 15m 的地铁车站公共区应设置消防专用通道。', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.8', '除仓库连廊、冷库穿堂和筒仓工作塔内的消防电梯可不设', '除仓库连廊、冷库穿堂和筒仓工作塔内的消防电梯可不设', '消防,消防电梯');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.11', '建筑高度大于 250m 的工业与民用建筑，应在屋顶设置', '建筑高度大于 250m 的工业与民用建筑，应在屋顶设置', '建筑,民用建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.12', '屋顶直升机停机坪的尺寸和面积应满足直升机安全起降', '屋顶直升机停机坪的尺寸和面积应满足直升机安全起降', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.13', '供直升机救助使用的设施应避免火灾或高温烟气的直接', '供直升机救助使用的设施应避免火灾或高温烟气的直接', '火灾');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '2.2.15', '消防通信指挥系统的主要性能应符合下列规定：', '消防通信指挥系统的主要性能应符合下列规定：', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.1.1', '建筑的总平面布局应符合减小火灾危害、方便消防救援的', '建筑的总平面布局应符合减小火灾危害、方便消防救援的', '消防,火灾,建筑,救援,消防救援');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.2.1', '甲类厂房与人员密集场所的防火间距不应小于 50m ，与明', '甲类厂房与人员密集场所的防火间距不应小于 50m ，与明', '防火,甲类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.2.2', '甲类仓库与高层民用建筑和设置人员密集场所的民用建筑', '甲类仓库与高层民用建筑和设置人员密集场所的民用建筑', '建筑,民用建筑,甲类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.2.3', '除乙类第 5 项、第 6 项物品仓库外，乙类仓库与高层民用建', '除乙类第 5 项、第 6 项物品仓库外，乙类仓库与高层民用建', '乙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.2.4', '飞机库与甲类仓库的防火间距不应小于 20m。飞机库与', '飞机库与甲类仓库的防火间距不应小于 20m。飞机库与', '防火,甲类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.3.1', '除裙房与相邻建筑的防火间距可按单、多层建筑确定外，', '除裙房与相邻建筑的防火间距可按单、多层建筑确定外，', '防火,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.3.2', '相邻两座通过连廊、天桥或下部建筑物等连接的建筑，防', '相邻两座通过连廊、天桥或下部建筑物等连接的建筑，防', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.4.2', '下列建筑应至少沿建筑的两条长边设置消防车道：', '下列建筑应至少沿建筑的两条长边设置消防车道：', '消防,消防车道,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.4.3', '除受环境地理条件限制只能设置 1 条消防车道的公共建', '除受环境地理条件限制只能设置 1 条消防车道的公共建', '消防,消防车道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.4.4', '供消防车取水的天然水源和消防水池应设置消防车道，天', '供消防车取水的天然水源和消防水池应设置消防车道，天', '消防,消防车道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.4.5', '消防车道或兼作消防车道的道路应符合下列规定：', '消防车道或兼作消防车道的道路应符合下列规定：', '消防,消防车道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '3.4.6', '高层建筑应至少沿其一条长边设置消防车登高操作场地。', '高层建筑应至少沿其一条长边设置消防车登高操作场地。', '消防,建筑,高层建筑,登高,操作场地');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.2.1', '除特殊工艺要求外，下列场所不应设置在地下或半地下：', '除特殊工艺要求外，下列场所不应设置在地下或半地下：', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.2.2', '厂房内不应设置宿舍。直接服务千生产的办公室、休息室', '厂房内不应设置宿舍。直接服务千生产的办公室、休息室', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.2.3', '设置在厂房内的甲、乙、丙类中间仓库，应采用防火墙和耐', '设置在厂房内的甲、乙、丙类中间仓库，应采用防火墙和耐', '防火,防火墙,丙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.2.4', '与甲、乙类厂房贴邻并供该甲、乙类厂房专用的 lOkV 及', '与甲、乙类厂房贴邻并供该甲、乙类厂房专用的 lOkV 及', '乙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.2.6', '仓库内的防火分区或库房之间应采用防火墙分隔，甲、乙类', '仓库内的防火分区或库房之间应采用防火墙分隔，甲、乙类', '防火,防火墙,防火分区,分隔,乙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.1', '民用建筑内不应设置经营、存放或使用甲、乙类火灾危险', '民用建筑内不应设置经营、存放或使用甲、乙类火灾危险', '火灾,建筑,民用建筑,乙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.2', '住宅与非住宅功能合建的建筑应符合下列规定：', '住宅与非住宅功能合建的建筑应符合下列规定：', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.3', '商店营业厅、公共展览厅等的布置应符合下列规定：', '商店营业厅、公共展览厅等的布置应符合下列规定：', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.4', '、 5. 1 、 5. 1 、 6. 6 、 6. 1(3) 、 6. 3 、 6. 6 、 6. ', '、 5. 1 、 5. 1 、 6. 6 、 6. 1(3) 、 6. 3 、 6. 6 、 6. 3 、', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.6', '医疗建筑中住院病房的布置和分隔应符合下列规定：', '医疗建筑中住院病房的布置和分隔应符合下列规定：', '建筑,分隔');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.7', '歌舞娱乐放映游艺场所的布置和分隔应符合下列规定：', '歌舞娱乐放映游艺场所的布置和分隔应符合下列规定：', '分隔');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.11', '燃气调压用房、瓶装液化石油气瓶组用房应独立建造，不', '燃气调压用房、瓶装液化石油气瓶组用房应独立建造，不', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.12', '建筑内使用天然气的部位应便于通风和防爆泄压。', '建筑内使用天然气的部位应便于通风和防爆泄压。', '建筑,防爆,通风');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.13', '四级生物安全实验室应独立划分防火分区，或与三级生 生物安全实验室根据实验室所处理对象的生物危险程度', '四级生物安全实验室应独立划分防火分区，或与三级生 生物安全实验室根据实验室所处理对象的生物危险程度', '防火,防火分区');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.14', '交通车站、码头和机场的候车建筑乘客公共区、', '交通车站、码头和机场的候车建筑乘客公共区、', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.15', '一、二级耐火等级建筑内的商店营业厅，当设置自动灭火 本条明确了商店营业厅设置在一、二级耐火等级单层、', '一、二级耐火等级建筑内的商店营业厅，当设置自动灭火 本条明确了商店营业厅设置在一、二级耐火等级单层、多', '耐火,耐火等级,自动灭火,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.16', '除有特殊要求的建筑、木结构建筑和附建于民用建筑中', '除有特殊要求的建筑、木结构建筑和附建于民用建筑中', '建筑,民用建筑,木结构建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.3.17', '总建筑面积大于 20000m2 的地下或半地下商店，应分隔 本条针对总建筑面积大于 20000面的地', '总建筑面积大于 20000m2 的地下或半地下商店，应分隔 本条针对总建筑面积大于 20000面的地下、半地下商店，要', '建筑,分隔');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.4.2', '地铁车站的站厅、站台、出入口通道、换乘通道、换乘厅与', '地铁车站的站厅、站台、出入口通道、换乘通道、换乘厅与', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.4.3', '地铁工程中的下列场所应分别独立设置，并应采用防火门', '地铁工程中的下列场所应分别独立设置，并应采用防火门', '防火,防火门');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.4.4', '在地铁车辆基地建筑的上部建造其他功能的建筑时，车辆', '在地铁车辆基地建筑的上部建造其他功能的建筑时，车辆', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '4.4.5', '交通隧道内的变电站、管廊、专用疏散通道、通风机房及其 公路隧道和城市交通隧道的变电站、管廊、专用疏散', '交通隧道内的变电站、管廊、专用疏散通道、通风机房及其 公路隧道和城市交通隧道的变电站、管廊、专用疏散通道、', '疏散,通风');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '5.2.2', '除本规范第 5. 2. 1 条规定的建筑外，下列工业建筑的耐火 本条规定的厂房和仓库均为发生火灾后易', '除本规范第 5. 2. 1 条规定的建筑外，下列工业建筑的耐火 本条规定的厂房和仓库均为发生火灾后易造成较严重损失', '耐火,火灾,建筑,工业建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '5.2.4', '物流建筑以丙、丁类物品收发、储存、装卸、搬运、分拣、物', '物流建筑以丙、丁类物品收发、储存、装卸、搬运、分拣、物', '建筑,丁类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '5.3.3', '除本规范第 5. 3. 1 条、第 5. 3. 2 条规定的建筑外，下列民', '除本规范第 5. 3. 1 条、第 5. 3. 2 条规定的建筑外，下列民', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '5.4.2', '交通隧道承重结构体的耐火性能应与其车流晕、隧道封闭 交通隧道的空间狭长且相对封闭，火灾的烟热排出困难', '交通隧道承重结构体的耐火性能应与其车流晕、隧道封闭 交通隧道的空间狭长且相对封闭，火灾的烟热排出困难，外', '耐火,火灾');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '5.4.3', '城市交通隧道的消防救援出入口的耐火等级不应低千一 服务于城市交通陇道的设备用房，主要包括隧道的通风与', '城市交通隧道的消防救援出入口的耐火等级不应低千一 服务于城市交通陇道的设备用房，主要包括隧道的通风与', '耐火,耐火等级,消防,通风,救援');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.2.2', '住宅分户墙、住宅单元之间的墙体、防火隔墙与建筑外墙、', '住宅分户墙、住宅单元之间的墙体、防火隔墙与建筑外墙、', '防火,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.2.3', '建筑外墙上、下层开口之间应采取防止火灾沿外墙开口蔓', '建筑外墙上、下层开口之间应采取防止火灾沿外墙开口蔓', '火灾,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.2.4', '本条规定为建筑外幕墙的基本防火要求，以防止火势经外', '本条规定为建筑外幕墙的基本防火要求，以防止火势经外', '防火,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.3.3', '除通风管道井、送风管道井、排烟管道井、必须通风的燃气', '除通风管道井、送风管道井、排烟管道井、必须通风的燃气', '排烟,通风,管道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.3.4', '电气线路和各类管道穿过防火墙、防火隔墙、竖井井壁、建', '电气线路和各类管道穿过防火墙、防火隔墙、竖井井壁、建', '防火,防火墙,电气,管道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.3.5', '、6. 1(2 、3 、4、5 、6) 、6.4.2 、6.4.3(1 、 3 、4、 5 、 6)', '、6. 1(2 、3 、4、5 、6) 、6.4.2 、6.4.3(1 、 3 、4、 5 、 6) 、 6. 4.4 、 6. 5 、 通风和空气调节系统的管道、防烟与排烟系统的管道穿过', '防烟,排烟,通风,管道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.2', '、6.4.3 这两条规定了建筑内应采用甲级或乙级防火门的', '、6.4.3 这两条规定了建筑内应采用甲级或乙级防火门的', '防火,防火门,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.3', '除建筑直通室外和屋面的门可采用普通门外，下列部位的', '除建筑直通室外和屋面的门可采用普通门外，下列部位的', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.4', '电气竖井、管道井、排烟道、排气道、垃圾道等竖井井壁上', '电气竖井、管道井、排烟道、排气道、垃圾道等竖井井壁上', '排烟,电气,管道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.5', '平时使用的人民防空工程中代替甲级防火门的防护门、防', '平时使用的人民防空工程中代替甲级防火门的防护门、防', '防火,防火门');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.6', '设置在防火墙和要求耐火极限不低于 3. ooh 的防火隔墙', '设置在防火墙和要求耐火极限不低于 3. ooh 的防火隔墙', '防火,耐火,防火墙');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.7', '下列部位的窗的耐火性能不应低于乙级防火窗的要求：', '下列部位的窗的耐火性能不应低于乙级防火窗的要求：', '防火,耐火,防火窗');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.8', '、6.4. 17 、 6. 2(1 、 2 、 3 、 4 、 9) 、6. 3 、 6. 6 、 ', '、6.4. 17 、 6. 2(1 、 2 、 3 、 4 、 9) 、6. 3 、 6. 6 、 6. 4 、 6. 7 、', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.4.9', '防火玻璃墙可用千替代防火隔墙。本条规定了防火玻璃', '防火玻璃墙可用千替代防火隔墙。本条规定了防火玻璃', '防火');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.1', '、6. 5. 2 这两条规定了建筑内部装修涉及消防安全的禁止', '、6. 5. 2 这两条规定了建筑内部装修涉及消防安全的禁止', '消防,建筑,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.2', '下列部位不应使用影响人员安全疏散和消防救援的镜面', '下列部位不应使用影响人员安全疏散和消防救援的镜面', '疏散,消防,救援,消防救援');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.3', '下列部位的顶棚、墙面和地面内部装修材料的燃烧性能均 避难走道、避难间或避难层、疏散楼梯间及其前室、消', '下列部位的顶棚、墙面和地面内部装修材料的燃烧性能均 避难走道、避难间或避难层、疏散楼梯间及其前室、消防电梯', '疏散,疏散楼梯,消防,消防电梯,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.4', '消防控制室地面装修材料的燃烧性能不应低于 B 级，顶', '消防控制室地面装修材料的燃烧性能不应低于 B 级，顶', '消防,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.5', '歌舞娱乐放映游艺场所内部装修材料的燃烧性能应符合 歌舞娱乐放映游艺场所多年来一直是容易发生火灾并且', '歌舞娱乐放映游艺场所内部装修材料的燃烧性能应符合 歌舞娱乐放映游艺场所多年来一直是容易发生火灾并且', '火灾,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.6', '下列场所设置在地下或半地下时，室内装修材料不应使用 交通建筑中的公共区为人员聚集的场所，特别是位千地', '下列场所设置在地下或半地下时，室内装修材料不应使用 交通建筑中的公共区为人员聚集的场所，特别是位千地下', '建筑,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.7', '除有特殊要求的场所外，下列生产场所和仓库的顶棚、墙', '除有特殊要求的场所外，下列生产场所和仓库的顶棚、墙', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.5.8', '建筑的外部装修和户外广告牌的设置，应满足防止火灾通', '建筑的外部装修和户外广告牌的设置，应满足防止火灾通', '火灾,建筑,装修');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.2', '建筑的外围护结构采用保温材料与两侧不燃性结构构成尤', '建筑的外围护结构采用保温材料与两侧不燃性结构构成尤', '建筑,保温');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.3', '飞机库的外围护结构、内部隔墙和屋面保温隔热层，均应', '飞机库的外围护结构、内部隔墙和屋面保温隔热层，均应', '保温');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.5', '除本规范第 6. 6. 2 条规定的情况外，下列建筑或场所的外', '除本规范第 6. 6. 2 条规定的情况外，下列建筑或场所的外', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.6', '除本规范第 6. 6. 2 条规定的情况外，住宅建筑采用与基层', '除本规范第 6. 6. 2 条规定的情况外，住宅建筑采用与基层', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.8', '除本规范第 6. 6. 3 条～第 6. 6. 5 条规定的建筑外，其他建 本条规定是对不同高度建筑', '除本规范第 6. 6. 3 条～第 6. 6. 5 条规定的建筑外，其他建 本条规定是对不同高度建筑中有空腔外墙外保温系统中', '建筑,保温');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.9', '下列场所或部位内保温系统中保温材料或制品的燃烧性', '下列场所或部位内保温系统中保温材料或制品的燃烧性', '保温');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '6.6.10', '除本规范第 6. 6. 3 条和第 6. 6. 9 条规定的场所或部位', '除本规范第 6. 6. 3 条和第 6. 6. 9 条规定的场所或部位', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.1.1', '建筑的疏散出口数量、位置和宽度，疏散楼梯的形式', '建筑的疏散出口数量、位置和宽度，疏散楼梯的形式', '疏散,疏散楼梯,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.1.17', '汽车库或修车库的室内疏散楼梯应符合下列规定：', '汽车库或修车库的室内疏散楼梯应符合下列规定：', '疏散,疏散楼梯');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.2.3', '占地面积大于 300面的地上仓库，安全出口不应少于 2 个；建', '占地面积大于 300面的地上仓库，安全出口不应少于 2 个；建', '安全出口');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.2.4', '高层仓库的疏散楼梯应为封闭楼梯间或室外楼梯。', '高层仓库的疏散楼梯应为封闭楼梯间或室外楼梯。', '疏散,疏散楼梯,楼梯间');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.3.1', '住宅建筑中符合下列条件之一的住宅单元，每层的安全出 本条针对单元式住宅建筑规定了住宅建筑应至少设置 ', '住宅建筑中符合下列条件之一的住宅单元，每层的安全出 本条针对单元式住宅建筑规定了住宅建筑应至少设置 2 个', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.3.2', '、7.3.5(2 、 3 、 4) 、 7. 6 、 8. 2、 8. 3 、 8. 6 、 8. ', '、7.3.5(2 、 3 、 4) 、 7. 6 、 8. 2、 8. 3 、 8. 6 、 8. (1 、 3 、 4) 、', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.4.2', '公共建筑内每个房间的疏散门不应少千 2 个；儿童活动场', '公共建筑内每个房间的疏散门不应少千 2 个；儿童活动场', '疏散,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.4.3', '位千高层建筑内的儿童活动场所，安全出口和疏散楼梯应 儿童对疏散设施的要求与成人有所区别，儿童活动场所', '位千高层建筑内的儿童活动场所，安全出口和疏散楼梯应 儿童对疏散设施的要求与成人有所区别，儿童活动场所与', '疏散,安全出口,疏散楼梯,建筑,高层建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.4.6', '剧场、电影院、礼堂和体育馆的观众厅或多功能厅的疏散', '剧场、电影院、礼堂和体育馆的观众厅或多功能厅的疏散', '疏散');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.4.7', '除剧场、电影院、礼堂、体育馆外的其他公共建筑，疏散出', '除剧场、电影院、礼堂、体育馆外的其他公共建筑，疏散出', '疏散,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.4.8', '匠疗建筑的用途决定了其中有部分人员在火灾时难以及', '匠疗建筑的用途决定了其中有部分人员在火灾时难以及', '火灾,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.5.1', '地铁车站中站台公共区至站厅公共区或其他安全区域的', '地铁车站中站台公共区至站厅公共区或其他安全区域的', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.5.3', '两条单线载客运营地下区间之间应设置联络通道，载客运', '两条单线载客运营地下区间之间应设置联络通道，载客运', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.5.4', '地铁工程中的出入口控制装置，应具有与火灾自动报警系', '地铁工程中的出入口控制装置，应具有与火灾自动报警系', '火灾');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '7.5.5', '城市综合管廊工程的每个舱室均应设置人员逃生口和消', '城市综合管廊工程的每个舱室均应设置人员逃生口和消', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '8.1.10', '除敞开式汽车库可不设置自动灭火设施外， I 、 II 、 ill 类', '除敞开式汽车库可不设置自动灭火设施外， I 、 II 、 ill 类', '自动灭火');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '8.1.12', '下列建筑应设置与室内消火栓等水灭火系统供水管网直', '下列建筑应设置与室内消火栓等水灭火系统供水管网直', '建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '8.3.1', '除散装粮食仓库、原煤仓库可不设置火灾自动报警系统 、8.3.2 火灾自动报警系统具有早期发现火灾信息', '除散装粮食仓库、原煤仓库可不设置火灾自动报警系统 、8.3.2 火灾自动报警系统具有早期发现火灾信息，及早发', '火灾');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '8.3.3', '本条规定应设置可燃气休探测报警装置的场所，包括各类生', '本条规定应设置可燃气休探测报警装置的场所，包括各类生', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '9.2.1', '甲、乙类火灾危险性场所内不应采用明火、燃气红外线辐', '甲、乙类火灾危险性场所内不应采用明火、燃气红外线辐', '火灾,火灾危险性,乙类');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '9.2.3', '采用燃气红外线辐射供暖的场所，应采取防火和通风换气', '采用燃气红外线辐射供暖的场所，应采取防火和通风换气', '防火,通风');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '9.3.3', '排除有燃烧或爆炸危险性气体、蒸气或粉尘的排风系统应', '排除有燃烧或爆炸危险性气体、蒸气或粉尘的排风系统应', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '10.0.9', '、11. 2. 2 、 11. 2. 5 、 11. 3. 1 、 11. 3. 2 、 12. 1', '、11. 2. 2 、 11. 2. 5 、 11. 3. 1 、 11. 3. 2 、 12. 1. 1 、 12. 1. 3 、 12. 1. 10 、', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '10.2.4', '城市交通隧道内的供电线路应与其他管道分开敷设，在', '城市交通隧道内的供电线路应与其他管道分开敷设，在', '管道');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '10.2.5', '架空电力线路不应跨越生产或储存易燃、易爆物质的建', '架空电力线路不应跨越生产或储存易燃、易爆物质的建', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '11.0.10', '、 12. 1. 3 、 12. 1. 4 、 12.3. 1 、 12. 5. 1 、 12. 5', '、 12. 1. 3 、 12. 1. 4 、 12.3. 1 、 12. 5. 1 、 12. 5.4 条。', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.1', '市政消火栓、室外消火栓、消防水泵接合器等室外消防设', '市政消火栓、室外消火栓、消防水泵接合器等室外消防设', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.2', '本条规定是保障消防车道和消防车登高场地随时可用的', '本条规定是保障消防车道和消防车登高场地随时可用的', '消防,消防车道,登高');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.3', '地下、半地下场所内不应使用或储存闪点低于 60C 的液', '地下、半地下场所内不应使用或储存闪点低于 60C 的液', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.4', '本条根据液化石油气的火灾危险性规定了瓶装液化石油', '本条根据液化石油气的火灾危险性规定了瓶装液化石油', '火灾,火灾危险性');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.5', '存放瓶装液化石油气和使用可燃气体、可燃液体的房间，', '存放瓶装液化石油气和使用可燃气体、可燃液体的房间，', '消防');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.6', '在建筑使用或运营期间，应确保疏散出口、疏散通道畅', '在建筑使用或运营期间，应确保疏散出口、疏散通道畅', '疏散,建筑');
insert into public.building_codes (code_name, clause_no, title, content, keywords) values ('GB 55037-2022', '12.0.7', '照明灯具使用应满足消防安全要求，开关、插座和照明灯', '照明灯具使用应满足消防安全要求，开关、插座和照明灯', '消防');
-- 导入完成
