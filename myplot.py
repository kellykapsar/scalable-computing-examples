import matplotlib.pyplot as plt

def myplot(df, var):

        var_labs = {'discharge_m_3_s': 'Total Discharge (m^3/s)',
                    'total_pressure_m': 'Total Pressure (m)',
                    'air_pressure_m': 'Air Pressure (m)',
                    'stage_m': 'Stage (m)',
                    'temperature_degrees_c': 'Temperature (C)'}

        fig, ax = plt.subplots(figsize=(7, 7))
        plt.plot(df['date'], df[var])
        plt.xticks(rotation = 45)
        ax.set_ylabel(var_labs.get(var))