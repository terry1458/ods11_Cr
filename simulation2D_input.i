[Executioner]  
type = Steady  # 选择合适的求解器类型，具体取决于你的模拟需求  
solve_type = Direct  # 求解类型，可根据需要选择其他类型（如Krylov等）

[Mesh]  
type = GeneratedMesh  # 网格类型，使用生成的网格  
dim = 2  # 网格维度，可以选择3（对于3D问题）  
num_x = 10  # 网格的x维度数量 
num_y = 10  # 网格的y维度数量  
xmin = 0.0  # x坐标最小值  
xmax = 1.0  # x坐标最大值  
ymin = 0.0  # y坐标最小值  
ymax = 1.0  # y坐标最大值

[Variables] 

[./alpha] 
type = Real 
initial_condition = 1.0 # 初始时只有α相 
[../] 

[./gamma] 
type = Real 
initial_condition = 0.0 # 初始时没有γ相 
[../] 

[./oxide_particles] 
type = Real 
initial_condition = 0.1 # 氧化物颗粒体积分数为 0.1
[../] 
[../]

[Materials] 
[./phase_field_material_alpha] 
type = GeneralizedPhaseFieldMaterial phase_field = alpha 
pinning_effect = oxide_particles # 引入氧化物颗粒的影响 
r = 0.005 # 假设氧化物颗粒的半径为0.1（可以根据实际情况调整）
gamma_interface = 0.5 # 假设界面能为0.5（可以根据实际情况调整）
phi = "oxide_particles" #氧化物颗粒的体积分数由oxide_particles变量决定
zener_pinning_strength = "3 * gamma_interface * phi / (2 * r)" # Zener钉扎效应
[../] 
[../]

[Materials] 
[./phase_field_material_gamma] 
type = GeneralizedPhaseFieldMaterial phase_field = gamma 
pinning_effect = oxide_particles # 引入氧化物颗粒的影响 
r = 0.005 # 假设氧化物颗粒的半径为0.1（可以根据实际情况调整）
gamma_interface = 0.5 # 假设界面能为0.5（可以根据实际情况调整）
phi = "oxide_particles" #氧化物颗粒的体积分数由oxide_particles变量决定
zener_pinning_strength = "3 * gamma_interface * phi / (2 * r)" # Zener钉扎效应
[../] 
[../]


[Boundary Conditions]  
[./boundary_condition_1]    
type = NeumannBC  # 无通量边界条件（表示不改变相场的梯度）    
variable = alpha    
boundary = "left"  
[../]  
[./boundary_condition_2]    
type = NeumannBC  # 无通量边界条件    
variable = alpha    
boundary = "right"  
[../]  
[./boundary_condition_3]    
type = NeumannBC  # 无通量边界条件    
variable = gamma    
boundary = "left"  
[../]  
[./boundary_condition_4]    
type = NeumannBC  # 无通量边界条件    
variable = gamma    
boundary = "right"  
[../]
[../]

[Initial Conditions]  
[./initial_condition_1]    
variable = alpha    
value = 1.0  
[../]  
[./initial_condition_2]    
variable = gamma    
value = 0.0  
[../]
[../]

[Outputs]  
[./output_1]    
type = Exodus    
interval = 1    
file = "output_file.exo" 
[../]
[../]


