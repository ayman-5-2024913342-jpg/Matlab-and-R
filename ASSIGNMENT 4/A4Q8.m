clc
close all
clear all

disp("=========== Part (a) =============")
hw_a = [65, 79, 80, 50, 71, 73, 61, 70, 69, 74];
mid_a = [83, 91];
final_a = 84;
scale_factor = 80;

grade_a = compute_course_grade(hw_a, mid_a, final_a, scale_factor);
fprintf("Overall course grade for case (a): %.2f\n", grade_a);

disp("=========== Part (b) =============")
hw_b = [70, 69, 83, 45, 90, 89, 52, 78, 100, 87];
mid_b = [87, 72];
final_b = 90;
scale_factor = 100;

grade_b = compute_course_grade(hw_b, mid_b, final_b, scale_factor);
fprintf("Overall course grade for case (b): %.2f\n", grade_b);

function course_grade = compute_course_grade(hw, midterms, final_exam, scale_factor)
    sorted_hw = sort(hw);
    higher_hw = sorted_hw(3:end); 
    avg_hw = mean(higher_hw);
    
    hw_score = (avg_hw / scale_factor) * 20;
    hw_component = hw_score;
    R
    avg_mid = mean(midterms);
    
    if avg_mid >= final_exam
        mid_component = avg_mid * 0.40;
        final_component = final_exam * 0.40;
    else
        mid_component = avg_mid * 0.30;
        final_component = final_exam * 0.50;
    end
    
    course_grade = hw_component + mid_component + final_component;
end























