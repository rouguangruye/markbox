import 'package:flutter_test/flutter_test.dart';
import 'package:markbox/models/email_list_item.dart';

void main() {
  group('EmailListItem 模型测试', () {
    // 固定的测试时间
    final testDate = DateTime(2024, 1, 15, 10, 30, 0);

    test('创建 EmailListItem 实例', () {
      // 准备测试数据
      final item = EmailListItem(
        uid: 'msg001',
        senderName: '张三',
        senderEmail: 'zhangsan@example.com',
        subject: '测试邮件主题',
        receivedDate: testDate,
        isRead: false,
      );

      // 验证属性
      expect(item.uid, 'msg001');
      expect(item.senderName, '张三');
      expect(item.senderEmail, 'zhangsan@example.com');
      expect(item.subject, '测试邮件主题');
      expect(item.receivedDate, testDate);
      expect(item.isRead, false);
    });

    test('创建 EmailListItem 实例（使用默认 isRead 值）', () {
      // 准备测试数据（不指定 isRead）
      final item = EmailListItem(
        uid: 'msg002',
        senderName: '李四',
        senderEmail: 'lisi@example.com',
        subject: '另一封邮件',
        receivedDate: testDate,
      );

      // 验证 isRead 默认为 false
      expect(item.isRead, false);
    });

    test('EmailListItem JSON 序列化', () {
      // 创建实例
      final item = EmailListItem(
        uid: 'msg003',
        senderName: '王五',
        senderEmail: 'wangwu@example.com',
        subject: '序列化测试',
        receivedDate: testDate,
        isRead: true,
      );

      // 序列化为 JSON
      final json = item.toJson();

      // 验证 JSON 内容
      expect(json['uid'], 'msg003');
      expect(json['senderName'], '王五');
      expect(json['senderEmail'], 'wangwu@example.com');
      expect(json['subject'], '序列化测试');
      expect(json['receivedDate'], testDate.toIso8601String());
      expect(json['isRead'], true);
    });

    test('EmailListItem JSON 反序列化', () {
      // 准备 JSON 数据
      final json = {
        'uid': 'msg004',
        'senderName': '赵六',
        'senderEmail': 'zhaoliu@example.com',
        'subject': '反序列化测试',
        'receivedDate': testDate.toIso8601String(),
        'isRead': false,
      };

      // 反序列化
      final item = EmailListItem.fromJson(json);

      // 验证属性
      expect(item.uid, 'msg004');
      expect(item.senderName, '赵六');
      expect(item.senderEmail, 'zhaoliu@example.com');
      expect(item.subject, '反序列化测试');
      expect(item.receivedDate, testDate);
      expect(item.isRead, false);
    });

    test('EmailListItem JSON 反序列化（缺少 isRead 字段）', () {
      // 准备 JSON 数据（不包含 isRead）
      final json = {
        'uid': 'msg005',
        'senderName': '测试用户',
        'senderEmail': 'test@example.com',
        'subject': '测试',
        'receivedDate': testDate.toIso8601String(),
      };

      // 反序列化
      final item = EmailListItem.fromJson(json);

      // 验证 isRead 默认为 false
      expect(item.isRead, false);
    });

    test('EmailListItem 相等性比较', () {
      // 创建两个相同的实例
      final item1 = EmailListItem(
        uid: 'msg006',
        senderName: '相同用户',
        senderEmail: 'same@example.com',
        subject: '相同主题',
        receivedDate: testDate,
        isRead: true,
      );

      final item2 = EmailListItem(
        uid: 'msg006',
        senderName: '相同用户',
        senderEmail: 'same@example.com',
        subject: '相同主题',
        receivedDate: testDate,
        isRead: true,
      );

      // 验证相等性
      expect(item1, equals(item2));
    });

    test('EmailListItem 不相等性比较', () {
      // 创建两个不同的实例
      final item1 = EmailListItem(
        uid: 'msg007',
        senderName: '用户A',
        senderEmail: 'userA@example.com',
        subject: '主题A',
        receivedDate: testDate,
        isRead: false,
      );

      final item2 = EmailListItem(
        uid: 'msg008',
        senderName: '用户B',
        senderEmail: 'userB@example.com',
        subject: '主题B',
        receivedDate: testDate,
        isRead: true,
      );

      // 验证不相等
      expect(item1, isNot(equals(item2)));
    });

    test('EmailListItem copyWith 方法', () {
      // 创建原始实例
      final original = EmailListItem(
        uid: 'msg009',
        senderName: '原始发件人',
        senderEmail: 'original@example.com',
        subject: '原始主题',
        receivedDate: testDate,
        isRead: false,
      );

      // 使用 copyWith 修改部分属性
      final modified = original.copyWith(isRead: true, subject: '修改后的主题');

      // 验证修改后的属性
      expect(modified.uid, 'msg009'); // 未修改
      expect(modified.senderName, '原始发件人'); // 未修改
      expect(modified.senderEmail, 'original@example.com'); // 未修改
      expect(modified.subject, '修改后的主题'); // 已修改
      expect(modified.receivedDate, testDate); // 未修改
      expect(modified.isRead, true); // 已修改
    });

    test('EmailListItem toString 方法', () {
      // 创建实例
      final item = EmailListItem(
        uid: 'msg010',
        senderName: '测试发件人',
        senderEmail: 'test@example.com',
        subject: '测试主题',
        receivedDate: testDate,
        isRead: false,
      );

      // 验证 toString 输出包含关键信息
      final str = item.toString();
      expect(str, contains('EmailListItem'));
      expect(str, contains('msg010'));
      expect(str, contains('测试发件人'));
    });

    test('EmailListItem 序列化和反序列化循环', () {
      // 创建实例
      final original = EmailListItem(
        uid: 'msg011',
        senderName: '循环测试',
        senderEmail: 'cycle@example.com',
        subject: '序列化反序列化循环测试',
        receivedDate: DateTime.utc(2024, 6, 20, 15, 45, 30),
        isRead: true,
      );

      // 序列化后反序列化
      final json = original.toJson();
      final restored = EmailListItem.fromJson(json);

      // 验证数据一致性
      expect(restored.uid, original.uid);
      expect(restored.senderName, original.senderName);
      expect(restored.senderEmail, original.senderEmail);
      expect(restored.subject, original.subject);
      expect(restored.receivedDate, original.receivedDate);
      expect(restored.isRead, original.isRead);
    });
  });
}
