import XCTest
@testable import ElapsedDayShared

final class ElapsedDayModelTests: XCTestCase {
    
    func testDaysElapsed() {
        let calendar = Calendar.current
        let today = Date()
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        // Test same day
        XCTAssertEqual(ElapsedDayModel.daysElapsed(from: today, to: today), 0)
        
        // Test one day elapsed
        XCTAssertEqual(ElapsedDayModel.daysElapsed(from: yesterday, to: today), 1)
        
        // Test future date (should return 0)
        XCTAssertEqual(ElapsedDayModel.daysElapsed(from: tomorrow, to: today), 0)
    }
    
    func testEffectiveLabel() {
        // Test with empty string
        let model = ElapsedDayModel.self
        XCTAssertEqual(model.effectiveLabel(), model.defaultLabel)
        
        // Note: We can't easily test the actual label property without affecting UserDefaults
        // In a real test environment, you might want to inject a mock UserDefaults
    }
    
    func testDefaultValues() {
        XCTAssertEqual(ElapsedDayModel.defaultLabel, "Since...")
        XCTAssertNotNil(ElapsedDayModel.defaultStartDate)
    }
} 